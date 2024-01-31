// import 'package:flutter/cupertino.dart';
//
// import 'models/RecipesModel.dart';
//
// class Details extends StatelessWidget {
//   final RecipesModel recipe;
//   const Details({super.key, required this.recipe});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// details_screen.dart
import 'package:flutter/material.dart';
import '../models/RecipesModel.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final RecipesModel recipe;
  RecipeDetailsScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.RecipeName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Area: ${recipe.Area}'),
            Text('Category: ${recipe.Category}'),
            Text('Procedure: ${recipe.Procedure}'),
            // Add other details based on your model
            SizedBox(height: 20),
            Text('Tags: ${recipe.Tags}'),
            Text('Favorite: ${recipe.Fav ? 'Yes' : 'No'}'),
            Text('In Shopping List: ${recipe.InShoppingList ? 'Yes' : 'No'}'),
            SizedBox(height: 20),
            Text('Recipe Date: ${recipe.RecipeDate.toString()}'),
          ],
        ),
      ),
      backgroundColor: Colors.cyanAccent,
    );
  }
}
// recipes_controller.dart




