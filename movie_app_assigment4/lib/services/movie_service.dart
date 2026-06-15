/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 4: Remote Data & APIs
   Summer 2026

   Popcorn Vault App
*/

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieService {
  static const String baseUrl = 'https://www.omdbapi.com/';
  static const String apiKey = '';     // Enter your API Key Here. Example: static const String apiKey = 'Your API Key';

  // Fetches movie search results from the OMDb API
  Future<List<MovieModel>> fetchMovies(String searchTerm) async {
    final url = Uri.parse('$baseUrl?s=$searchTerm&type=movie&apikey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['Response'] == 'False') {
        throw Exception(jsonData['Error'] ?? 'Failed to load movies');
      }

      final movieResponse = MovieResponse.fromJson(jsonData);
      return movieResponse.search;
    } else {
      throw Exception('Failed to connect to API');
    }
  }

  // Fetches full details for a selected movie
  Future<MovieModel> fetchMovieDetails(String imdbID) async {
    final url = Uri.parse('$baseUrl?i=$imdbID&plot=full&apikey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['Response'] == 'False') {
        // Display the API error message if the request fails
        throw Exception(jsonData['Error'] ?? 'Failed to load details');
      }

      return MovieModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to connect to API');
    }
  }
}
