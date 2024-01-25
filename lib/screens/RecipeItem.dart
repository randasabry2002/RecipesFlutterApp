import 'package:flutter/material.dart';

import 'categoruandrecipe.dart';

class RecipeItem extends StatelessWidget {
  final dynamic recipe; // Accept both Recipe and Category
  final VoidCallback onFavoritePressed;

  // Constructor to initialize RecipeItem
  RecipeItem({required this.recipe, required this.onFavoritePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 200, // Set the width as needed
      height: 200, // Set a fixed height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            Image.asset(
              recipe is Recipe ? recipe.imageUrl : recipe.imageUrlCategory,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        recipe is Recipe ? recipe.name : recipe.nameCategory,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.0), // Add some spacing
                    IconButton(
                      icon: Icon(
                        recipe is Recipe
                            ? (recipe.isFavorite ? Icons.favorite : Icons.favorite_border)
                            : Icons.star, // Use appropriate icon for Category
                        color: Colors.red,
                      ),
                      onPressed: onFavoritePressed,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
