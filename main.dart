// main.dart
import 'package:flutter/material.dart';
import 'login_page.dart';

void main() => runApp(DigitalTwinApp());

class DigitalTwinApp extends StatelessWidget {
  const DigitalTwinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TwinVerse',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        fontFamily: 'Arial',
      ),
      home: LoginPage(),
    );
  }
}

class SessionManager {
  static String? userEmail;
  static bool get isLoggedIn => userEmail != null;
}
