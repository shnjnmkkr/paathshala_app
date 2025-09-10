import 'package:flutter/material.dart';
import 'pages/loading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://skxrcuucsvqasmvsjwjl.supabase.co",   // 👈 replace
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNreHJjdXVjc3ZxYXNtdnNqd2psIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTczMTkxODcsImV4cCI6MjA3Mjg5NTE4N30.CCxhWPkq3FSxIRuRoZLr6Le62EYCBqqEd4rDpXQvT1A",                     // 👈 replace
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home:   SplashPage(),
    );
  }
}

