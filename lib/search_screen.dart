import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/movie_controller.dart';
import 'details_screen.dart';
import 'movie_list.dart';
import 'movie_model.dart';

class SearchScreen extends StatelessWidget {
  final MovieController movieController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (movieController.isSearching.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (movieController.searchQuery.isEmpty) {
          // Show "All Shows" section when no search is active
          return buildAllShowsList(movieController.allMovies);
        } else if (movieController.searchedMovies.isEmpty) {
          // Show "No Shows found" if search results are empty
          return Center(
            child: Text(
              "No Shows found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        // Display search results in grid format with only images, titles, and summaries
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: movieController.searchedMovies.length,
          itemBuilder: (context, index) {
            final movie = movieController.searchedMovies[index];
            return GestureDetector(
              onTap: () => Get.to(() => DetailsScreen(movie: movie)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      movie.image ?? 'https://via.placeholder.com/150', // Placeholder if image is null
                      fit: BoxFit.cover,
                      height: 120,
                      width: double.infinity,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      movie.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      movie.summary,
                      style: TextStyle(
                          color: Colors.white70, fontSize: 12.0),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      backgroundColor: Colors.black,
    );
  }

  // "All Shows" list using MovieListItem with title and summary
  Widget buildAllShowsList(RxList<Movie> allMovies) {
    if (allMovies.isEmpty) return SizedBox.shrink();

    return ListView.builder(
      itemCount: allMovies.length,
      itemBuilder: (context, index) {
        final movie = allMovies[index];
        return GestureDetector(
          onTap: () => Get.to(() => DetailsScreen(movie: movie)),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    movie.image ?? 'https://via.placeholder.com/150',
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        movie.summary,
                        style: TextStyle(
                            color: Colors.white70, fontSize: 12.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
