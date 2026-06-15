/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 4: Remote Data & APIs
   Summer 2026

   Popcorn Vault App
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Gets the current app settings from the provider
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Preferences',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Dark mode setting card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          movieProvider.isDarkMode
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          "Cinematic Dark Mode",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: movieProvider.isDarkMode,
                      activeThumbColor: Theme.of(context).primaryColor,
                      onChanged: (value) {
                        // Update the app theme when the switch changes
                        movieProvider.toggleDarkMode(value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
