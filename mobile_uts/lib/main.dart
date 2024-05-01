import 'package:flutter/material.dart';
import 'package:mobile_uts/screens/homepage.dart';
import 'package:mobile_uts/screens/login.dart';
import 'package:mobile_uts/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rifqi Munawar R.',
      home: Splash(),
    );
  }
}
