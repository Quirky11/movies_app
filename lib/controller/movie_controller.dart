import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../movie_model.dart';
import 'package:intl/intl.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var isSearching = false.obs;
  var actionMovies = <Movie>[].obs;
  var comedyMovies = <Movie>[].obs;
  var dramaMovies = <Movie>[].obs;
  var horrorMovies = <Movie>[].obs;
  var sciFiMovies = <Movie>[].obs;
  var newMovies = <Movie>[].obs;
  var searchedMovies = <Movie>[].obs; // Add searchedMovies list here

  // Store different genres here
  var genres = ['Action', 'Comedy', 'Drama', 'Horror', 'Sci-Fi'];

  @override
  void onInit() {
    // Fetch movies for each genre when initializing
    fetchMoviesByGenre();
    super.onInit();
  }

  // Fetch movies by genre and update movies list
  void fetchMoviesByGenre() async {
    isLoading(true);

    // Get the current date and the date one month ago
    DateTime currentDate = DateTime.now();
    DateTime oneMonthAgo = currentDate.subtract(Duration(days: 30));

    // Loop through genres and fetch movies for each
    for (var genre in genres) {
      final response = await http.get(Uri.parse("https://api.tvmaze.com/search/shows?q=$genre"));

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        var movieList = data.map((movie) => Movie.fromJson(movie)).toList();

        // Filter out movies with invalid image URLs
        movieList = movieList.where((movie) {
          return _isValidImageUrl(movie.image);
        }).toList();

        // Filter movies released within the last month and add them to 'newMovies' list
        for (var movie in movieList) {
          DateTime? releaseDate = _parseReleaseDate(movie.summary); // You may need to extract release date from the summary or another field
          if (releaseDate != null && releaseDate.isAfter(oneMonthAgo) && releaseDate.isBefore(currentDate)) {
            newMovies.add(movie);
          }
        }

        // Add the filtered movies for the specific genre to the corresponding list
        switch (genre) {
          case 'Action':
            actionMovies.addAll(movieList);
            break;
          case 'Comedy':
            comedyMovies.addAll(movieList);
            break;
          case 'Drama':
            dramaMovies.addAll(movieList);
            break;
          case 'Horror':
            horrorMovies.addAll(movieList);
            break;
          case 'Sci-Fi':
            sciFiMovies.addAll(movieList);
            break;
        }
      }
    }

    isLoading(false);
  }

  // Helper function to validate image URL
  bool _isValidImageUrl(String imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return false;

    final uri = Uri.tryParse(imageUrl);
    return uri != null && uri.isAbsolute;
  }

  // Helper function to parse release date (assuming it's included in the summary or another field)
  DateTime? _parseReleaseDate(String summary) {
    // You would need to implement a way to parse the release date from the summary or other field
    // For now, we will return null (this part may need customization based on the API response)
    return null;
  }

  // Search movies based on query
  void searchMovies(String query) async {
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
