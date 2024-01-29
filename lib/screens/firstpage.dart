import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'FavoritePage.dart';
import 'homepage.dart';

class FirstPage extends StatelessWidget {
  //looping on pages
  final RxInt counterIndex = 0.obs; // Use RxInt for reactive state

  final List<Widget> pages = [
    HomeScreen(),
    FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(
          // Use Obx to listen to changes in counterIndex
              () => BottomNavigationBar(
            currentIndex: counterIndex.value,
            onTap: (index) {
              counterIndex.value = index; // Update the counterIndex on tap
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
            ],
          ),
        ),
        body: pages[counterIndex.value],
      ),
    );
  }
}

