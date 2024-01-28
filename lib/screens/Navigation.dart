import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FavoritePage.dart';
import 'homePage.dart';

class Navigation extends StatefulWidget{

  @override
  State<Navigation> createState() {

    return NavigationState();
  }
}

class NavigationState extends State<Navigation> {
  int counterindex = 0;

  List<Widget> get pages => [
    HomeScreen(),
    FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: counterindex,
          onTap: (index) {
            setState(() {
              counterindex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),

          ],
        ),
        body: pages[counterindex],
      ),
    );
  }
}

