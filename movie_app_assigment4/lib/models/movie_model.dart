/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 4: Remote Data & APIs
   Summer 2026

   Popcorn Vault App
*/

class MovieResponse {
  final List<MovieModel> search;

  MovieResponse({required this.search});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    // Return movie results only when the API request is successful
    if (json['Response'] == 'True' && json['Search'] != null) {
      return MovieResponse(
        search: (json['Search'] as List)
            .map((movieJson) => MovieModel.fromJson(movieJson))
            .toList(),
      );
    }
    return MovieResponse(search: []);
  }
}

// Movie details shown on the info screen
class MovieModel {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;
  final String? plot;
  final String? rating;
  final String? actors;
  final String? genre;
  final String? runtime;

  MovieModel({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
    this.plot,
    this.rating,
    this.actors,
    this.genre,
    this.runtime,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['Title'] ?? 'Unknown Title',
      year: json['Year'] ?? 'Unknown Year',
      imdbID: json['imdbID'] ?? '',
      type: json['Type'] ?? 'Unknown',
      poster: json['Poster'] != 'N/A'
          ? json['Poster']
          : 'https://via.placeholder.com/500x750?text=No+Poster',
      plot: json['Plot'] == 'N/A' ? 'No plot available.' : json['Plot'],
      rating: json['imdbRating'] == 'N/A' ? 'N/A' : json['imdbRating'],
      actors: json['Actors'] == 'N/A' ? 'Unknown Cast' : json['Actors'],
      genre: json['Genre'] == 'N/A' ? 'Unknown Genre' : json['Genre'],
      runtime: json['Runtime'] == 'N/A' ? 'Unknown' : json['Runtime'],
    );
  }
}