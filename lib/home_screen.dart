import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/navigation_controller.dart';
import 'movie_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  final NavigationController navigationController = Get.put(NavigationController()); // Inject NavigationController

  final List<Widget> _pages = [
    MovieScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0,
        title: Text('Movies', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Update selectedIndex when navigating to the search screen
              navigationController.updateIndex(1);
              Get.to(() => SearchScreen());
            },
          ),
        ],
      ),
      body: GetBuilder<NavigationController>( // Observe the state changes in the NavigationController
        builder: (controller) {
          return PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged, // Sync PageView with the selected index
            children: _pages,
          );
        },
      ),
      bottomNavigationBar: GetBuilder<NavigationController>(
        builder: (controller) {
          return BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: controller.selectedIndex.value, // Bind the current index to reactive state
            onTap: (index) {
              controller.updateIndex(index); // Update the selected index
              controller.pageController.jumpToPage(index); // Jump to the respective page in PageView
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
        },
      ),
    );
  }
}
