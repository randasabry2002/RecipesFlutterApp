import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/RecipesController.dart';
import 'DetailsPage.dart';

class CategoryPageeeee extends StatelessWidget {
  final String categoryName;

  CategoryPageeeee({required this.categoryName});

  final RecipesController categoryController = Get.put(RecipesController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories',
            style: TextStyle(fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          elevation: 0.0,
        ),
        body: FutureBuilder(
          // The FutureBuilder widget is used to asynchronously fetch and display data.
          // It takes a Future (in this case, categoryController.filterRecipesByCategory(categoryName))
          // and rebuilds the UI based on the result of the Future.
          future: categoryController.filterRecipesByCategory(categoryName),
          builder: (context, snapshot) {
            // The builder function is called each time the Future completes.
            if (snapshot.connectionState == ConnectionState.waiting) {
              // If the Future is still in progress, display a loading indicator.
              return Center(
                //is used to display a loading spinner at the center of the screen.
                child: CircularProgressIndicator(),
              );
            }
      
            // Once the Future completes, display the fetched data.
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20,),
                // Display the category name at the top of the screen.
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      "$categoryName Recipes",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.green),
                    ),
                  ),
                ),
      
                // Expanded widget is used to take all available vertical space.
                Expanded(
                  child: ListView.builder(
                    // The number of items in the list is determined by the length of RecipesByCategory.
                    itemCount: categoryController.RecipesByCategory.length,
                    // The itemBuilder function is called for each item in the list.
                    itemBuilder: (context, index) {
                      // Get the recipe at the current index.
                      var recipe = categoryController.RecipesByCategory[index];
      
                      // GestureDetector allows tapping on the list item.
                      return GestureDetector(
                        onTap: () {
                          // Navigate to RecipeDetailsScreen when an item is tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailsScreen(recipe: recipe),
                            ),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          elevation: 5,
                          child: ListTile(
                            // Display the recipe name as the title of the ListTile
                            title: Text(
                              recipe.RecipeName ?? '', // If RecipeName is null, display an empty string
                              style: TextStyle(fontSize: 16),
                            ),
                            // Display the recipe area as the subtitle of the ListTile
                            subtitle: Text(
                              recipe.Area ?? '', // If Area is null, display an empty string
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            // Display a circular avatar with the recipe image as the leading element of the ListTile
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(recipe.RecipeImage ?? ''), // If RecipeImage is null, display an empty string
                            ),
                          ),
                        ),
                      );
      
                    },
                  ),
                ),
              ],
            );
          },
        ),
      
      ),
    );
  }
}
