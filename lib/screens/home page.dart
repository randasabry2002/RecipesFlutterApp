import 'package:flutter/material.dart';

// Define a Recipe class to represent a recipe item
class Recipe {
  final String name;
  final String imageUrl;
  bool isFavorite;

  // Constructor to initialize the recipe
  Recipe({required this.name, required this.imageUrl, this.isFavorite = false});
}

// StatefulWidget for the home screen
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() {
    return HomeScreenState();
  }
}

// State class for the home screen
class HomeScreenState extends State<HomeScreen> {
  // List of Recipe objects representing recipes
  List<Recipe> recipes = [
    Recipe(name: 'Spaghetti', imageUrl: 'assets/images/spaghetti_image.jpg'),
    Recipe(name: 'Pizza', imageUrl: 'assets/images/pizza.png'),
    Recipe(name: 'Burger', imageUrl: 'assets/images/burger_image.jpg'),
    Recipe(name: 'Salad', imageUrl: 'assets/images/salad.png'),
    Recipe(name: 'Spaghetti', imageUrl: 'assets/images/spaghetti_image.jpg'),
    Recipe(name: 'Pizza', imageUrl: 'assets/images/pizza.png'),
    Recipe(name: 'Burger', imageUrl: 'assets/images/burger_image.jpg'),
    Recipe(name: 'Salad', imageUrl: 'assets/images/salad.png'),
    // Add more recipes as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: Container(
        color: Colors.orange[300],
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: recipes.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Recipe recipe = recipes[index];
            return RecipeItem(
              recipe: recipe,
              onFavoritePressed: () {
                setState(() {
                  recipe.isFavorite = !recipe.isFavorite; // Toggle isFavorite
                });
              },
            );
          },
        ),
      ),
    );
  }
}

// StatelessWidget to represent a recipe item
class RecipeItem extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onFavoritePressed;

  // Constructor to initialize RecipeItem
  RecipeItem({required this.recipe, required this.onFavoritePressed});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      width: 200, // Set the width as needed
      margin: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            recipe.imageUrl,
            width: double.infinity,
            height: 150, // Adjust the height as needed
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  recipe.name,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: onFavoritePressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
