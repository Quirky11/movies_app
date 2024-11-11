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
            // "All Shows" section
            buildAllShowsSection(movieController.allMovies),
            // "New" movies section
            buildNewMoviesSection(movieController.newMovies),
            buildCategorySection("Action", movieController.actionMovies),
            buildCategorySection("Comedy", movieController.comedyMovies),
            buildCategorySection("Drama", movieController.dramaMovies),
            buildCategorySection("Horror", movieController.horrorMovies),
            buildCategorySection("Anime", movieController.animeMovies),
          ],
        );
      }),
      backgroundColor: Colors.black,
    );
  }

  // "All Shows" section with title and summary
  Widget buildAllShowsSection(RxList<Movie> allMovies) {
    if (allMovies.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Text(
            "All Shows",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 250, // Increased height to accommodate title and summary
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: allMovies.length,
            itemBuilder: (context, index) {
              final movie = allMovies[index];
              return GestureDetector(
                onTap: () => Get.to(() => DetailsScreen(movie: movie)),
                child: Container(
                  width: 160,
                  margin: EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.black, // Different shade for background
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          movie.image,
                          height: 120,
                          width: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        movie.title,
                        style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        movie.summary,
                        style: TextStyle(color: Colors.white70, fontSize: 12.0),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // "New" movies section (Movies released within the last month)
  Widget buildNewMoviesSection(RxList<Movie> newMovies) {
    if (newMovies.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Text(
            "New",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 250, // Increased height to accommodate title and summary
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newMovies.length,
            itemBuilder: (context, index) {
              final movie = newMovies[index];
              return GestureDetector(
                onTap: () => Get.to(() => DetailsScreen(movie: movie)),
                child: Container(
                  width: 160,
                  margin: EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.black, // Different shade for background
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          movie.image,
                          height: 120,
                          width: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        movie.title,
                        style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        movie.summary,
                        style: TextStyle(color: Colors.white70, fontSize: 12.0),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Genre movies section with title and summary
  Widget buildCategorySection(String genre, RxList<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Text(
            genre,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 250, // Increased height to accommodate title and summary
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () => Get.to(() => DetailsScreen(movie: movie)),
                child: Container(
                  width: 160,
                  margin: EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.black, // Different shade for background
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          movie.image,
                          height: 120,
                          width: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        movie.title,
                        style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        movie.summary,
                        style: TextStyle(color: Colors.white70, fontSize: 12.0),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
