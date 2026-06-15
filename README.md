# Assignment 4: Remote Data & APIs

**Project Name:** movie_app_assignment4  
**App Name:** Popcorn Vault

**Popcorn Vault** is a movie discovery application built with Flutter. It allows users to search for movies by franchise or perform custom title searches, view detailed information, and manage theme settings.

## Features
* **Franchise Browsing:** Quickly access popular movie universes (such as Harry Potter, Transformer, or Star Wars).
* **Custom Search:** Type in text search  to find any movie title.
* **Detailed Views:** Movie detail screens featuring poster art, movie title, and release year.
* **Settings Customization:** User-friendly settings panel for managing application theme preferences.
* **Cinematic Design:** A dark-themed, professional UI with custom branding and optimized grid layouts for the results screen.

## Technical Highlights
* **API Request and JSON Models:** Integrated the **OMDb API** to perform asynchronous movie searches and retrieve real-time data. Created strongly typed Dart model classes to parse `JSON` responses and simplify data management throughout the application.
* **Architectural Pattern:** Utilized the `Provider` state management pattern to separate the service layer from the UI layer, improving code organization, maintainability, and scalability.
* **Network & Data Handling:** Implemented asynchronous data fetching via the `http` package, incorporating robust parsing models to map JSON responses into strongly-typed Dart objects.
* **Results List or Grid:** Implemented a dynamic movie grid using `GridView.builder` and `AspectRatio` to efficiently display search results. Each item presents the movie poster, title, and release year. Each grid provides an intuitive interface for user interaction.
* **Lifecycle & Navigation Security:** Integrated strict `context.mounted` checks and `null` safety protocols to prevent runtime exceptions during asynchronous navigation cycles.
* **Error, Empty State, and Code Organization:** Added error handling and empty-state feedback to improve the user experience when `API` requests fail, return no results, and when detail information is not avaiable. Organized the project using a modular architecture with separate models, providers, services, and UI components to enhance readability and maintainability.
* **System Integration:** Configured `flutter_launcher_icons` to generate the default application icons for both Android and iOS platforms, ensuring consistent branding across devices. Additionally, updated the application name to **Popcorn Vault** on both platforms to provide a unified user experience and reinforce the app's branding.


## Prerequisites
* Flutter SDK installed
* Get your API Key for [OMDb API](https://www.omdbapi.com/apikey.aspx) **$$\color{red}{\text{<-- IMPORTANT}}$$**   (for security reasons I omitted my API key)
    * Just click the link above and enter your email. The API key is free. 


## Getting Started
To run this project locally:
1. Clone the repository to your machine.
2. Navigate to the project directory: `cd movie_app_assignment4`
3. Install dependencies: `flutter pub get`
4. **$$\color{red}{\text{(IMPORTANT)}}$$ Configuration:** Open `lib/services/movie_service.dart` and place your actual OMDb API key in between the '' on line 15. Remember to save the file before preceeding to step 5.
5. Launch the application: `flutter run`

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
