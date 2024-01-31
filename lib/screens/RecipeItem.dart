import 'package:flutter/material.dart';
import '../models/RecipesModel.dart';

class RecipeItem extends StatelessWidget {
  final RecipesModel recipe;
  final Function()? onTap;
  final Function()? onFavoritePressed;

  RecipeItem({
    required this.recipe,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 200.0,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Recipe Image (Add an Image Widget here)
              // Example: Image.network(recipe.RecipeImage, height: 100.0, fit: BoxFit.cover),

              // Display Recipe Name
              Text(
                recipe.RecipeName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // Display Recipe Category
              Text(
                recipe.Category,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),

              // Add Favorite Button (Use IconButton)
              IconButton(
                icon: Icon(
                  recipe.Fav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: onFavoritePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
