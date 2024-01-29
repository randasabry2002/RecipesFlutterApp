import 'package:flutter/material.dart';

import 'RecipeItem.dart';
import 'recipe.dart';
import 'categoryItem.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() {
    return HomeScreenState();
  }
}

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
  ];

  // List of Category objects representing categories
  List<CategoryItem> categories = [
    CategoryItem(nameCategory: 'Spaghetti', imageUrlCategory: 'assets/images/spaghetti_image.jpg'),
    CategoryItem(nameCategory: 'Pizza', imageUrlCategory: 'assets/images/pizza.png'),
    CategoryItem(nameCategory: 'Burger', imageUrlCategory: 'assets/images/burger_image.jpg'),
    CategoryItem(nameCategory: 'Salad', imageUrlCategory: 'assets/images/salad.png'),
    CategoryItem(nameCategory: 'Spaghetti', imageUrlCategory: 'assets/images/spaghetti_image.jpg'),
    CategoryItem(nameCategory: 'Pizza', imageUrlCategory: 'assets/images/pizza.png'),
    CategoryItem(nameCategory: 'Burger', imageUrlCategory: 'assets/images/burger_image.jpg'),
    CategoryItem(nameCategory: 'Salad', imageUrlCategory: 'assets/images/salad.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search bar at the top of the screen
            // Container for the search bar at the top of the screen
            Container(
              // Add horizontal padding to the container
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              // Apply decoration to the container, setting color and border radius
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              // Row widget to contain search icon, input field, and other widgets horizontally
              child: Row(
                children: [
                  // Icon for the search, with grey color
                  Icon(Icons.search, color: Colors.grey[700]),
                  // SizedBox for adding space between icon and input field
                  SizedBox(width: 8.0),
                  // Expanded widget to allow the TextField to take the remaining space
                  Expanded(
                    child: Container(
                      // Add horizontal padding to the input field container
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      // TextField widget for user input
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        // Decoration for the input field, including placeholder text and no border
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey[700]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            // Horizontal list of categories
            // Container for displaying a horizontal list of categories
            Text("Category Section",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 15),
            Container(
              // Set the height of the container
              height: 100,
              // Set the background color of the container to orange with a shade
              color: Colors.orange[300],
              // ListView.builder for efficiently building a scrollable list of widgets
              child: ListView.builder(
                // Number of items in the list is based on the length of the 'categories' list
                itemCount: categories.length,
                // Set the scroll direction to horizontal
                scrollDirection: Axis.horizontal,
                // Builder function for creating each item in the list dynamically
                itemBuilder: (context, index) {

                  // Get the category at the current index from the 'categories' list
                  CategoryItem category = categories[index];
                  // Return a CategoryItem widget with details from the current category
                  return CategoryItem(
                    nameCategory: category.nameCategory,
                    imageUrlCategory: category.imageUrlCategory,
                  );
                },
              ),
            ),


            SizedBox(height: 20),
            // Horizontal list of recipes with a toggle button for marking as favorite
            Text("meals Section",
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,)
              ,),

            SizedBox(height: 15),
            Container(
              height: 300,
              color: Colors.orange[300],
              child: ListView.builder(
                itemCount: recipes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Recipe recipe = recipes[index];
                  return RecipeItem(
                    recipe: recipe,
                    onFavoritePressed: () {
                      setState(() {
                        recipe.isFavorite = !recipe.isFavorite;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
