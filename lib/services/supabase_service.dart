import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<String?> getSignedVideoUrl() async {
    try {
      // Updated path to include the folder
      final response = await supabase.storage
          .from('Paathshala Videos') // bucket name
          .createSignedUrl('demo_vid/demo_master.m3u8', 60 * 60); // path inside bucket

      return response;
    } catch (e) {
      print("Error getting signed URL: $e");
      return null;
    }
  }
}
