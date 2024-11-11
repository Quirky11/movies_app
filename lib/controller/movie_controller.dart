import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../movie_model.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var isSearching = false.obs;
  var searchQuery = ''.obs; // New variable to store the current search query
  var actionMovies = <Movie>[].obs;
  var comedyMovies = <Movie>[].obs;
  var dramaMovies = <Movie>[].obs;
  var horrorMovies = <Movie>[].obs;
  var animeMovies = <Movie>[].obs; // Replaced sciFiMovies with animeMovies
  var newMovies = <Movie>[].obs;
  var searchedMovies = <Movie>[].obs;
  var allMovies = <Movie>[].obs; // List for all shows

  // Store different genres here
  var genres = ['Action', 'Comedy', 'Drama', 'Horror', 'Anime']; // Replaced Sci-Fi with Anime

  @override
  void onInit() {
    fetchAllMovies();
    fetchMoviesByGenre();
    super.onInit();
  }

  // Fetch all movies for "All Shows" section

// Modify the fetchAllMovies method
  void fetchAllMovies() async {
    isLoading(true);
    final response = await http.get(Uri.parse("https://api.tvmaze.com/search/shows?q=all"));

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      var movieList = data.map((movie) => Movie.fromJson(movie)).toList();

      // Filter out movies with invalid image URLs
      movieList = movieList.where((movie) => _isValidImageUrl(movie.image)).toList();

      // Shuffle the list to get a different order each time
      movieList.shuffle(Random());

      allMovies.assignAll(movieList);
    }
    isLoading(false);
  }


  // Fetch movies by genre and update movies list
  void fetchMoviesByGenre() async {
    isLoading(true);
    DateTime currentDate = DateTime.now();
    DateTime oneMonthAgo = currentDate.subtract(Duration(days: 30));

    for (var genre in genres) {
      final response = await http.get(Uri.parse("https://api.tvmaze.com/search/shows?q=$genre"));

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        var movieList = data.map((movie) => Movie.fromJson(movie)).toList();

        // Filter movies that actually belong to the specified genre
        movieList = movieList.where((movie) => movie.genres.contains(genre)).toList();

        // Filter out movies with invalid image URLs
        movieList = movieList.where((movie) {
          return _isValidImageUrl(movie.image);
        }).toList();

        // Filter movies released within the last month and avoid duplicates in `newMovies`
        for (var movie in movieList) {
          DateTime? releaseDate = _parseReleaseDate(movie.summary);
          if (releaseDate != null &&
              releaseDate.isAfter(oneMonthAgo) &&
              releaseDate.isBefore(currentDate) &&
              !newMovies.contains(movie)) {
            newMovies.add(movie);
          }
        }

        // Assign the filtered movies to the appropriate genre list
        switch (genre) {
          case 'Action':
            actionMovies.assignAll(movieList);
            break;
          case 'Comedy':
            comedyMovies.assignAll(movieList);
            break;
          case 'Drama':
            dramaMovies.assignAll(movieList);
            break;
          case 'Horror':
            horrorMovies.assignAll(movieList);
            break;
          case 'Anime': // Replaced Sci-Fi with Anime
            animeMovies.assignAll(movieList);
            break;
        }
      }
    }
    isLoading(false);
  }

  // Helper function to validate image URL
  bool _isValidImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return false;

    final uri = Uri.tryParse(imageUrl);
    return uri != null && uri.isAbsolute;
  }

  // Helper function to parse release date (assuming it's included in the summary or another field)
  DateTime? _parseReleaseDate(String? summary) {
    // Implement parsing logic based on the actual API response structure
    return null;
  }

  // Search movies based on query
  void searchMovies(String query) async {
    searchQuery.value = query; // Store the search term in searchQuery

    if (query.isEmpty) {
      searchedMovies.clear();
      return;
    }

    isSearching(true);

    // Fetch movies dynamically based on search query from the API
    final response = await http.get(Uri.parse("https://api.tvmaze.com/search/shows?q=$query"));

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      var movieList = data.map((movie) => Movie.fromJson(movie)).toList();

      // Filter out movies with invalid image URLs
      movieList = movieList.where((movie) {
        return _isValidImageUrl(movie.image);
      }).toList();

      searchedMovies.value = movieList;
    }

    isSearching(false);
  }
}
