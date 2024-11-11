import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String image;
  final String summary;
  final String premiered; // Premiere date
  final double? rating; // Average rating
  final List<String> genres; // List of genres// Trailer URL (official website)

  Movie({
    required this.title,
    required this.image,
    required this.summary,
    required this.premiered,
    required this.rating,
    required this.genres, // Initialize trailer URL
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['show']['name'] ?? '',
      image: json['show']['image'] != null ? json['show']['image']['medium'] : '',
      summary: _removeHtmlTags(json['show']['summary'] ?? ''),
      premiered: json['show']['premiered'] ?? '', // Premiere date
      rating: json['show']['rating'] != null ? json['show']['rating']['average']?.toDouble() : 0.0, // Rating
      genres: json['show']['genres'] != null ? List<String>.from(json['show']['genres']) : [], // Genres
    );
  }

  // Helper function to remove HTML tags
  static String _removeHtmlTags(String htmlText) {
    final RegExp htmlTagExp = RegExp(r'<[^>]*>');
    return htmlText.replaceAll(htmlTagExp, '');
  }

  // Helper function to parse the premiere date and check if it's within the last month
  bool isReleasedWithinLastMonth() {
    if (premiered.isEmpty) return false;

    // Parse the premiered date into DateTime
    DateTime premiereDate = DateTime.parse(premiered);

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the difference between current date and premiere date
    Duration difference = currentDate.difference(premiereDate);

    // Check if the movie was released within the last 30 days (1 month)
    return difference.inDays <= 30;
  }
}
