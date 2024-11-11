import 'package:flutter/material.dart';
import 'movie_model.dart';

class DetailsScreen extends StatelessWidget {
  final Movie movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          movie.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie poster
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                movie.image,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 15),

            // Movie title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                movie.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Summary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                movie.summary,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 20),

            // More details section (Rating, Genre, Release Date)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Allow horizontal scrolling for movie details
                child: Row(
                  children: [
                    _buildInfoCard('Rating', movie.rating != null ? '${movie.rating?.toStringAsFixed(1)}/10' : 'N/A'),
                    SizedBox(width: 10),
                    _buildInfoCard('Genre', movie.genres.isNotEmpty ? movie.genres.join(', ') : 'N/A'),
                    SizedBox(width: 10),
                    _buildInfoCard('Release Date', movie.premiered.isNotEmpty ? movie.premiered : 'N/A'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Info Card widget for displaying additional details like rating, genre, etc.
  Widget _buildInfoCard(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white30),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
