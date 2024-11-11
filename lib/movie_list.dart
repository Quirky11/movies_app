import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package for navigation
import '../movie_model.dart';
import '../details_screen.dart'; // Import DetailsScreen

class MovieListItem extends StatelessWidget {
  final Movie movie;

  const MovieListItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          // Movie Poster
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(movie.image ?? 'https://via.placeholder.com/80x120'),  // Placeholder in case of null
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Movie Title
          Expanded(
            child: Text(
              movie.title ?? 'Unknown',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),

          // Play Button Icon
          IconButton(
            onPressed: () {
              // Navigate to DetailsScreen on tap
              Get.to(() => DetailsScreen(movie: movie));
            },
            icon: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
