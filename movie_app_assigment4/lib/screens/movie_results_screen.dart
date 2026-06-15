/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 4: Remote Data & APIs
   Summer 2026

   Popcorn Vault App
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_detail_screen.dart';

class MovieResultsScreen extends StatelessWidget {
  const MovieResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();
    final movies = provider.movies;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Results',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: movies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.67,
            ),
            itemBuilder: (context, index) {
              final movie = movies[index];

              return InkWell(
                onTap: () async {
                  // Show a loading indicator while movie details are being fetched
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );

                  try {
                    // Get the full movie details using the IMDb ID
                    final detailedMovie = await provider.movieService
                        .fetchMovieDetails(movie.imdbID);

                    if (!context.mounted) return;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailScreen(movie: detailedMovie),
                      ),
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    Navigator.pop(context); // Close loading dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to load movie details.'),
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                },
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          movie.poster,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          // Show a placeholder if the poster image fails to load
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              color: const Color(0xFF2A2A2A),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Poster is Unavailable',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              '${movie.title} (${movie.year})',
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
