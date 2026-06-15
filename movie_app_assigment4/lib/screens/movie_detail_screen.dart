/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 4: Remote Data & APIs
   Summer 2026

   Popcorn Vault App
*/

import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Expanded(
                    child: Text(
                      'Movie Info',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Released: ${movie.year}',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    movie.poster,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    // Show a fallback message if the movie poster cannot be loaded
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 400,
                        width: double.infinity,
                        color: Theme.of(context).cardColor,
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                                size: 80,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Image Unavailable',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
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

              const SizedBox(height: 28),

              const Text(
                'Plot Summary',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                movie.plot ?? 'No plot available.',
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),

              const SizedBox(height: 28),

              _InfoSection(
                title: 'IMDb Rating',
                content: movie.rating != null ? '${movie.rating} / 10' : 'N/A',
              ),

              _InfoSection(title: 'Cast', content: movie.actors ?? 'Unknown'),

              _InfoSection(title: 'Genre', content: movie.genre ?? 'Unknown'),

              _InfoSection(
                title: 'Length',
                content: movie.runtime ?? 'Unknown',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Show a fallback message if the movie poster cannot be loaded
class _InfoSection extends StatelessWidget {
  final String title;
  final String content;
  const _InfoSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }
}
