// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData.dark(),
      home: SplashScreen(), // Start with SplashScreen
    );
  }
}
