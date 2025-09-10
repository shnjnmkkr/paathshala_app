import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import '../services/hls_downloader.dart';

// Services
import '../services/local_server.dart';
import '../services/supabase_service.dart';
import '../services/network_helper.dart';
import '../services/realtime_service.dart' as realtime;
import '../services/permission_helper.dart';
import '../services/helper_election.dart' as election;

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  final SupabaseService _supabaseService = SupabaseService();
  final LocalServer _localServer = LocalServer();
  final NetworkHelper _networkHelper = NetworkHelper();
  final realtime.RealtimeService _realtimeService = realtime.RealtimeService();

  bool isLAN = false;
  bool isHelper = false;
  String videoUrl = "";
  String? _myIp;
  String? _helperIp;
  bool _serverStarted = false;

  StreamSubscription? _peerSub;

  @override
  void initState() {
    super.initState();

    // Lock orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _setupVideo();
  }

  /// Initialize and play video from a URL
  Future<void> _initAndPlay(String url) async {
    try {
      _videoPlayerController?.dispose();
      _chewieController?.dispose();

      _videoPlayerController = VideoPlayerController.network(url);
      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
      );

      setState(() {});
    } catch (e) {
      print("Error initializing player: $e");
    }
  }

  Future<void> _setupVideo() async {
    try {
      // 1️⃣ Get network info
      final network = await _networkHelper.getNetworkDetails();
      if (network['status'] != 'wifi') {
        print("Not on WiFi, fallback to public HLS");
        await _startPublicStream();
        return;
      }

      _myIp = network['ip'];

      // Measure bandwidth
      Future<int> measureBandwidth() async {
        final url =
            'https://skxrcuucsvqasmvsjwjl.supabase.co/storage/v1/object/public/Paathshala%20Videos/demo_vid/demo_240p.m3u8';
        final stopwatch = Stopwatch()..start();
        final request = await HttpClient().getUrl(Uri.parse(url));
        final response = await request.close();
        final data =
            await response.fold<int>(0, (prev, element) => prev + element.length);
        stopwatch.stop();
        final elapsedMs = stopwatch.elapsedMilliseconds;
        if (elapsedMs == 0) return 1;
        return (data / 1024) ~/ (elapsedMs / 1000);
      }

      int bandwidth = await measureBandwidth();

      // Send stats to Supabase
      await _realtimeService.sendStats(network['ssid']!, _myIp!, bandwidth);

      // Listen to peers
      _peerSub = _realtimeService.listenToPeers().listen(
        (List<Map<String, dynamic>> peers) async {
          try {
            // Use helper election namespace to avoid ambiguity
            final helper = await election.electHelper(peers);

            if (helper != null) _helperIp = (helper['ip'] ?? '').toString();

            if (helper != null && helper['ip'] != _myIp) {
              // Non-helper: stream from helper
              isLAN = true;
              isHelper = false;
              videoUrl = "http://${helper['ip']}:8080/demo_master.m3u8";
              await _initAndPlay(videoUrl);
            } else {
              // I am the helper
              isLAN = true;
              isHelper = true;

              // Request storage permission
              bool granted = await PermissionHelper.requestStoragePermission();
              if (!granted) {
                await _startPublicStream();
                return;
              }

              // Download HLS folder
              final hlsDownloader = HlsDownloader();
              final localPath = await hlsDownloader.downloadHlsFolder(
                "Paathshala Videos",
                "demo_vid",
              );

              // Start local server
              if (!_serverStarted) {
                _localServer.startServer(localPath); // don't await
                _serverStarted = true;
              }

              // Play from local server
              if (_myIp != null) {
                videoUrl = "http://$_myIp:8080/demo_master.m3u8";
                await _initAndPlay(videoUrl);
              } else {
                await _startPublicStream();
              }
            }

            print(isLAN ? "Streaming over LAN: $videoUrl" : "Streaming via Supabase HLS: $videoUrl");
            if (isHelper) print("This device is acting as Helper ✅");
          } catch (inner) {
            print("Error inside peer listener: $inner");
          }
        },
      );
    } catch (e) {
      print("Error setting up video: $e");
      await _startPublicStream();
    }
  }

  Future<void> _startPublicStream() async {
    isLAN = false;
    isHelper = false;

    final signed = await _supabaseService.getSignedVideoUrl();
    videoUrl = signed ??
        "https://skxrcuucsvqasmvsjwjl.supabase.co/storage/v1/object/public/Paathshala%20Videos/demo_vid/demo_master.m3u8";

    await _initAndPlay(videoUrl);
  }

  @override
  void dispose() {
    // Unlock orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    _localServer.stopServer();
    _peerSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(controller: _chewieController!)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Colors.deepPurple),
                  const SizedBox(height: 16),
                  Text(
                    isLAN ? "Streaming over LAN" : "Using public HLS stream...",
                    style: const TextStyle(color: Colors.white),
                  ),
                  if (isHelper)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        " This device is acting as Helper",
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
