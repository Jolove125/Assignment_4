/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 4: Remote Data & APIs
   Summer 2026

   Popcorn Vault App
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/movie_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();

    return MaterialApp(
      title: 'Popcorn Vault',
      debugShowCheckedModeBanner: false,

      // Switches between light and dark theme based on user preference
      themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // LIGHT THEME (Clean White & Blue Accent)
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        primaryColor: Colors.blueAccent,
        colorScheme: const ColorScheme.light(
          primary: Colors.blueAccent,
          secondary: Colors.blueGrey,
          surface: Colors.white,
          onSurface: Color(0xFF0F172A),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        cardColor: Colors.white,

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Button is ALWAYS blue
            foregroundColor: Colors.white, // Text inside button is ALWAYS white
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),

      // DARK THEME (Deep Navy & Blue Accent)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: Colors.blueAccent,
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.grey,
          surface: Color(0xFF1E293B),
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F172A),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        cardColor: const Color(0xFF1E293B),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),

      home: const SplashScreen(),
    );
  }
}