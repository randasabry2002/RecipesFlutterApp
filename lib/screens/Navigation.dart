import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_flutter_app/screens/profile.dart';
import 'FavoritePage.dart';
import 'ShoppingListPage.dart';
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
    ProfilePage(),
    ShoppingListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: counterindex,
          onTap: (index) {
            setState(() {
              counterindex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
            BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart_rounded), label: "ShoppingList"),
          ],
        ),
        body: pages[counterindex],
      ),
    );
  }
}

