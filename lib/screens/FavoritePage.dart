import 'package:flutter/material.dart';

import 'homePage.dart';


class FavoritePage extends StatefulWidget {
 // final List<Recipe> favoriteRecipes;

 // const FavoritePage({Key? key, required this.favoriteRecipes}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Page'),
      ),
      body: Container(color: Colors.white,),
    );
  }
}