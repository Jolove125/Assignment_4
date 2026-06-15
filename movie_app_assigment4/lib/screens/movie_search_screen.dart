/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 4: Remote Data & APIs
   Summer 2026

   Popcorn Vault App
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_results_screen.dart';
import 'settings_screen.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final TextEditingController _customSearchController = TextEditingController();
  String selectedFranchise = "Batman";
  bool _isLoading = false;

  // Last option "Custom Search" lets the user type any movie title.
  final List<String> franchises = [
    "Batman",
    "Avengers",
    "Star Trek",
    "Star Wars",
    "Harry Potter",
    "Spider-Man",
    "Jurassic Park",
    "The Matrix",
    "Transformers",
    "James Bond",
    "Indiana Jones",
    "Custom Search...",
  ];

  @override
  void dispose() {
    _customSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if the custom search option is selected
    final isCustomSearch = selectedFranchise == "Custom Search...";

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
          child: Image.asset("assets/images/pop_vault.jpg", fit: BoxFit.contain),
        ),
        leadingWidth: 80,
        title: const Text(
          'Discover',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // Added the settings icon to the AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: 30,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Select a Franchise or Custom Search Your Movie',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose a movie franchise universe, or type in your movie after selecting Custom Search.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedFranchise,
                    isExpanded: true,
                    dropdownColor: Theme.of(context).cardColor,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    items: franchises.map((franchise) {
                      return DropdownMenuItem<String>(
                        value: franchise,
                        child: Text(
                          franchise,
                          style: TextStyle(
                            color: franchise == "Custom Search..."
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).colorScheme.onSurface,
                            fontWeight: franchise == "Custom Search..."
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedFranchise = value!;
                        
                        // Clear old custom text when switching back to a franchise
                        if (value != "Custom Search...") {
                          _customSearchController.clear();
                        }
                      });
                    },
                  ),
                ),
              ),

              if (isCustomSearch) ...[
                const SizedBox(height: 24),
                TextField(
                  controller: _customSearchController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Enter any movie title...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          // Use either the selected franchise or the custom movie title
                          String searchTerm = isCustomSearch
                              ? _customSearchController.text.trim()
                              : selectedFranchise;

                          if (isCustomSearch && searchTerm.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Please enter a movie title to search.',
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            );
                            return;
                          }

                          FocusScope.of(context).unfocus();

                          setState(() {
                            _isLoading = true;
                          });

                          final provider = context.read<MovieProvider>();
                          final navigator = Navigator.of(context);
                          final messenger = ScaffoldMessenger.of(context);
                          final theme = Theme.of(context);

                          await provider.fetchMovies(searchTerm);

                          if (!context.mounted) return;

                          setState(() {
                            _isLoading = false;
                          });

                          if (provider.errorMessage == null) {
                            navigator.push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MovieResultsScreen(),
                              ),
                            );
                          } else {
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(provider.errorMessage!),
                                backgroundColor: theme.primaryColor,
                              ),
                            );
                          }
                        },
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Search Movies',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}