import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;  // Reactive variable to hold the selected index
  var pageController = PageController();  // PageController for the PageView

  // Update the selected index and scroll to the page
  void updateIndex(int index) {
    selectedIndex.value = index;  // Update the selected index
    pageController.jumpToPage(index);  // Update the PageView to the selected page
  }

  // When the page changes, update the selected index
  void onPageChanged(int index) {
    selectedIndex.value = index;  // Update the index when the page changes
  }
}
