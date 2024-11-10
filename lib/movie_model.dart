// lib/models/movie_model.dart
class Movie {
  final String title;
  final String image;
  final String summary;
  final String premiered; // Add premiered field for release date

  Movie({required this.title, required this.image, required this.summary, required this.premiered});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['show']['name'] ?? '',
      image: json['show']['image'] != null ? json['show']['image']['medium'] : '',
      summary: json['show']['summary'] ?? '',
      premiered: json['show']['premiered'] ?? '', // Get the premiere date
    );
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
