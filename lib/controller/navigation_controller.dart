import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;  // Reactive variable to hold the selected index
  var pageController = PageController();  // PageController for the PageView

  void updateIndex(int index) {
    selectedIndex.value = index;  // Update the selected index
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;  // Update the index when page changes
  }
}
