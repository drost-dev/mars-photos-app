import 'package:flutter/material.dart';
import 'package:mars_photos_app/screen/home_screen/home_screen.dart';
import 'package:mars_photos_app/theme/default.dart';

//api key e6vTbGqmR1cgXiYFG28nLJm5gxEQK30csKuzDhEg

void main() {
  runApp(const MarsPhotosApp());
}

class MarsPhotosApp extends StatelessWidget {
  const MarsPhotosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme,
      home: const HomeScreen(),
    );
  }
}