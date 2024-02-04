// Import necessary packages and modules
import 'package:flutter/material.dart';
import '../models/RecipesModel.dart';

// Define a stateless widget for displaying a recipe item
class RecipeItem extends StatelessWidget {
  // Declare variables to store recipe details and callback functions
  final RecipesModel recipe;
  //represents a function with no parameters and no return value.
  // It is often used for callback functions that don't take any arguments.
  // for actions that don't require any parameters and don't return any values
  final VoidCallback onFavoritePressed;
  final Function()? onTap;
 // example
  //// Example usage of VoidCallback
  // VoidCallback myButtonCallback = () {
  //   print("Button pressed!");
  // };
  //
  // // Example usage of Function() for onTap
  // Function() myTapCallback = () {
  //   print("Item tapped!");
  // };
  //
  // // Usage in Flutter widget
  // IconButton(
  //   icon: Icon(Icons.favorite),
  //   onPressed: myButtonCallback,
  // );
  //
  // GestureDetector(
  //   onTap: myTapCallback,
  //   child: MyWidget(),
  // );

  // Constructor to initialize the recipe and callback functions
  RecipeItem({required this.recipe, required this.onFavoritePressed, this.onTap});

  @override
  Widget build(BuildContext context) {
    // InkWell provides a visual splash effect when the recipe item is tapped
    return InkWell(
      onTap: onTap,//put click on home page Navigate to recipe details when a meal is tapped to go to the meal with index
      child: Container(
        // Set margin for the container
        margin: EdgeInsets.all(10.0),
        // Set width and height for the container
        width: 200,
        height: 250,
        // Apply decoration with rounded corners and shadow
        // Apply a BoxDecoration to style the appearance of the container
        decoration: BoxDecoration(
          // Add rounded corners to the container
          borderRadius: BorderRadius.circular(12.0),

          // Apply a shadow to simulate elevation
          boxShadow: [
            BoxShadow(
              // Set the color of the shadow with some opacity
              color: Colors.grey.withOpacity(0.5),

              // Spread the shadow, controlling its size
              spreadRadius: 2,

              // Increase the blur radius for a softer shadow
              blurRadius: 7,

              // Offset the shadow horizontally (0) and vertically (3)
              offset: Offset(0, 3),
            ),
          ],
        ),
// ClipRRect widget clips its child using a rounded rectangle shape
        child: ClipRRect(
          // Set the borderRadius property to define the shape of the rounded rectangle
          borderRadius: BorderRadius.circular(12.0),
          // Stack widget allows for overlaying multiple children in a layered manner
          child: Stack(
            children: [
              // Display the recipe image fetched from the database
// Display an image from a network URL
              Image.network(
                // Provide the image URL from the 'recipe' model
                recipe.RecipeImage!,

                // Make the image take up the full width of its parent
                width: double.infinity,

                // Make the image take up the full height of its parent
                height: double.infinity,

                // Scale the image to cover the entire container, maintaining aspect ratio
                fit: BoxFit.cover,
              ),
              //show the name of recipe and favourite icon bellow the image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  // Apply gradient background for text visibility
                  padding: EdgeInsets.all(8.0),
// Apply a decoration to the container
                  decoration: BoxDecoration(
                    // Apply a gradient decoration to create a fading effect
                    gradient: LinearGradient(
                      // Start the gradient from the bottom center of the container
                      begin: Alignment.bottomCenter,

                      // End the gradient at the top center of the container
                      end: Alignment.topCenter,

                      // Define the colors for the gradient, transitioning from black to transparent
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // Define a child widget of type Text
                        child: Text(
                          // Display the recipe name
                          recipe.RecipeName!,

                          // Apply a text style with specified properties
                          style: TextStyle(
                            fontSize: 18.0,                // Set the font size to 18.0
                            fontWeight: FontWeight.bold,   // Set the font weight to bold
                            color: Colors.white,           // Set the text color to white
                          ),

                          // Handle text overflow by ellipsis if the content exceeds the available space
                          overflow: TextOverflow.ellipsis,
                        ),

                      ),
                      SizedBox(width: 8.0),
                      // Display a heart icon as a favorite indicator
                      // Define an IconButton widget
                      IconButton(
                        // Set the icon based on the favorite status of the recipe
                        icon: Icon(
                          // If the recipe is marked as a favorite, display a filled heart, otherwise, display an outlined heart
                          recipe.Fav! ? Icons.favorite : Icons.favorite_border,
                          // Set the color of the heart icon to red
                          color: Colors.red,
                        ),

                        // Define a callback function to be executed when the IconButton is pressed
                        onPressed: onFavoritePressed,
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
