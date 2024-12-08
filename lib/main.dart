import 'package:demo_app/screens/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white, 
          iconTheme: IconThemeData(color: Colors.white), 
        ),
        
        scaffoldBackgroundColor: Colors.white,
       
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 2,
        ),
        // Configure text theme for card titles
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // This ensures Material widgets like Card use white by default
        colorScheme: const ColorScheme.light(
          surface: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}


