import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class MathMashApp extends StatelessWidget {
  const MathMashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MathMash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}