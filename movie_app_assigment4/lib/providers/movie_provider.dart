/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 4: Remote Data & APIs
   Summer 2026

   Popcorn Vault App
*/

import 'dart:math';
import 'package:flutter/material.dart';
import '../models/intro_page.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  List<IntroPage> introPages = [];
  final MovieService movieService = MovieService();
  List<MovieModel> movies = [];
  String? errorMessage;

  Future<void> fetchMovies(String searchTerm) async {
    // Clear any previous error before starting a new search
    errorMessage = null;
    notifyListeners();

    try {
      movies = await movieService.fetchMovies(searchTerm);
    } catch (error) {
      errorMessage = error.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  void loadIntroPages() {
    // Prevent reloading pages if they were already created
    if (introPages.isNotEmpty) return;

    final captions = [
      "Discover the magic of cinema",
      "Find your next favorite film",
      "Explore details and ratings",
      "Start exploring movies today",
    ];

    final imagePaths = List.generate(
      7,
      (index) => 'assets/images/${index + 1}.jpg',
    );

    // Randomly pick 4 images for the intro screens
    imagePaths.shuffle(Random());
    final selectedImages = imagePaths.take(4).toList();

    introPages = List.generate(
      4,
      (index) =>
          IntroPage(imagePath: selectedImages[index], caption: captions[index]),
    );

    notifyListeners();
  }

  // Dark mode is enabled by default
  bool isDarkMode = true;

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }
}