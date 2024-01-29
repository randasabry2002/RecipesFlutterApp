import 'package:flutter/material.dart';

import 'recipe.dart';

class RecipeItem extends StatelessWidget {
  final dynamic recipe; // Accept both Recipe and Category
  final VoidCallback onFavoritePressed;

  // Constructor to initialize RecipeItem
  RecipeItem({required this.recipe, required this.onFavoritePressed});

  @override
  Widget build(BuildContext context) {
    return // Container for displaying a recipe or category item with fixed width and height
      Container(
        // Set margin around the container
        margin: EdgeInsets.all(10.0),
        // Set a fixed width for the container
        width: 200,
        // Set a fixed height for the container
        height: 200,
        // BoxDecoration to provide styling to the container
        decoration: BoxDecoration(
          // Apply rounded corners to the container
          borderRadius: BorderRadius.circular(12.0),
          // Apply a box shadow for a subtle elevation effect
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        //make rounded rectangle for image
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          // Stack to overlay multiple widgets on top of each other
          child: Stack(
            children: [
              // Image widget to display the recipe image
              Image.asset(
                // Choose the appropriate image URL based on item Recipe
                recipe is Recipe ? recipe.imageUrl : recipe.imageUrlCategory,
                // Make the image fill the available space
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              // Positioned widget to place the container at the bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                // Container to create a gradient overlay at the bottom
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  // LinearGradient to create a gradient from black to transparent
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                  // Row to display recipe or category details and favorite icon
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Expanded Text widget to display the recipe or category name
                      Expanded(
                        child: Text(
                          // Choose the appropriate name based on the type of item (Recipe or Category)
                          recipe is Recipe ? recipe.name : recipe.nameCategory,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          // Allow text to overflow with ellipsis if it's too long
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.0), // Add some spacing
                      // IconButton to display the favorite or star icon
                      IconButton(
                        icon: Icon(
                          //looping in recipe if user click on favourite make color red
                          recipe is Recipe
                              ? (recipe.isFavorite ? Icons.favorite : Icons.favorite_border)
                              : Icons.star,
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
