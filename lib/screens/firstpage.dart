
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FavoritePage.dart';

import 'home page.dart';

class firstpage extends StatefulWidget{

  @override
  State<firstpage> createState() {

    return firstpageState();
  }
}

class firstpageState extends State<firstpage> {
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

