import 'package:flutter/material.dart';
import 'screen/home_screen/home_screen.dart';
import 'theme/default.dart';

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
