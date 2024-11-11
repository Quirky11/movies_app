import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/navigation_controller.dart';
import 'controller/movie_controller.dart'; // Assuming you have a movie controller for search functionality
import 'movie_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  final NavigationController navigationController = Get.put(NavigationController());
  final MovieController movieController = Get.put(MovieController());

  // FocusNode for controlling the text field focus
  final FocusNode _focusNode = FocusNode();

  final List<Widget> _pages = [
    MovieScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // When the back button is pressed, unfocus the text field
        if (_focusNode.hasFocus) {
          _focusNode.unfocus(); // Remove focus from the text field
          return false; // Prevent the default back action
        }
        return true; // Allow back navigation if the text field is not focused
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: TextField(
            focusNode: _focusNode, // Attach the FocusNode to the TextField
            decoration: InputDecoration(
              hintText: "Search shows, anime, movies...",
              suffixIcon: Icon(Icons.search, color: Colors.white),
              filled: true,
              fillColor: Colors.grey[800],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: Colors.white),
            onTap: () {
              // Switch to the Search tab and make the TextField active
              if (navigationController.selectedIndex.value != 1) {
                navigationController.updateIndex(1); // Switch to the Search tab
                navigationController.pageController.jumpToPage(1); // Navigate to the Search page
              }
              _focusNode.requestFocus(); // Activate the text field immediately
            },
            onChanged: (query) {
              movieController.searchMovies(query); // Trigger search functionality
            },
          ),
        ),
        body: GetBuilder<NavigationController>(
          builder: (controller) {
            return GestureDetector(
              onTap: () {
                // When tapping anywhere else on the screen, unfocus the text field
                _focusNode.unfocus();
              },
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.onPageChanged(index);
                  _focusNode.unfocus(); // Dismiss the keyboard when swapping pages
                },
                children: _pages,
              ),
            );
          },
        ),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: navigationController.selectedIndex.value,
            onTap: (index) {
              navigationController.updateIndex(index);
              navigationController.pageController.jumpToPage(index);
              _focusNode.unfocus(); // Dismiss the keyboard when tapping on a bottom nav item
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
          );
        }),
      ),
    );
  }
}
