// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie App',
      theme: ThemeData.dark(), // Dark theme
      home: HomeScreen(),
    );
  }
}
