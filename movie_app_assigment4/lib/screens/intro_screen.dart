/* Latasha Glover
   COMP 6970-D02: Mobile Applications Development
   Assignment 4: Remote Data & APIs
   Summer 2026

   Popcorn Vault App
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_search_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Load the intro page data after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().loadIntroPages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    // Show a loading spinner until the intro data has finished loading
    if (provider.introPages.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: provider.introPages.length,
            itemBuilder: (context, index) {
              final page = provider.introPages[index];
              
              // Padding and rounded corners create the floating card effect
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        page.imagePath,
                        fit: BoxFit.cover,
                      ),
                     
                     // Dark gradient helps the caption stand out against the image
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              const Color(0xFF121212).withValues(alpha: 0.9),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          // Text, Indicators, and Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    provider.introPages[_currentPage].caption,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Animated dots show which intro page is currently active
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      provider.introPages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index 
                              ? Theme.of(context).primaryColor 
                              : Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  ElevatedButton(
                    onPressed: () {
                      // Use pushReplacement so users cannot navigate back to the intro screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MovieSearchScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
