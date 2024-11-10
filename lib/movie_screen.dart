import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/movie_controller.dart';
import 'details_screen.dart';
import '../movie_model.dart';

class MovieScreen extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (movieController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: [
            // "New" movies section
            buildNewMoviesSection(movieController.newMovies),
            buildCategorySection("Action", movieController.actionMovies), // Display Action movies
            buildCategorySection("Comedy", movieController.comedyMovies), // Display Comedy movies
            buildCategorySection("Drama", movieController.dramaMovies), // Display Drama movies
            buildCategorySection("Horror", movieController.horrorMovies), // Display Horror movies
            buildCategorySection("Sci-Fi", movieController.sciFiMovies), // Display Sci-Fi movies
          ],
        );
      }),
      backgroundColor: Colors.black,
    );
  }

  // "New" movies section (Movies released within the last month)
  Widget buildNewMoviesSection(RxList<Movie> newMovies) {
    if (newMovies.isEmpty) return SizedBox.shrink(); // If no new movies, return an empty space

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Text(
            "New", // Title for the new movies section
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
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
    );
  }

  // Genre movies section
  Widget buildCategorySection(String genre, RxList<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Text(
            genre, // Dynamic genre title
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
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
    );
  }
}
