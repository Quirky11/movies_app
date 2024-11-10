// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/movie_controller.dart';
import 'details_screen.dart';
import 'movie_model.dart';

class SearchScreen extends StatelessWidget {
  final MovieController movieController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Movies"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                suffixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (query) {
                movieController.searchMovies(query); // Trigger search
              },
            ),
          ),
          // Display the "New" movies section (from last month)
          buildNewMoviesSection(movieController.newMovies),
          Expanded(
            child: Obx(() {
              if (movieController.isSearching.value) {
                return Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 8.0, // Space between columns
                  mainAxisSpacing: 8.0, // Space between rows
                  childAspectRatio: 0.7, // Aspect ratio for each grid item
                ),
                itemCount: movieController.searchedMovies.length,
                itemBuilder: (context, index) {
                  final movie = movieController.searchedMovies[index];
                  return GestureDetector(
                    onTap: () => Get.to(() => DetailsScreen(movie: movie)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Column(
                        children: [
                          Image.network(
                            movie.image,
                            fit: BoxFit.cover,
                            height: 180, // Image height
                            width: double.infinity,
                          ),
                          SizedBox(height: 8),
                          Text(
                            movie.title,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      backgroundColor: Colors.black, // Dark background like Netflix
    );
  }

  // "New" movies section
  Widget buildNewMoviesSection(RxList<Movie> newMovies) {
    if (newMovies.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "New", // Title for the new movies section
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newMovies.length,
              itemBuilder: (context, index) {
                final movie = newMovies[index];
                return GestureDetector(
                  onTap: () => Get.to(() => DetailsScreen(movie: movie)),
                  child: Container(
                    width: 120,
                    margin: EdgeInsets.only(right: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        movie.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
