import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/RecipesController.dart';

class CategoryPageeeee extends StatelessWidget {
  final String categoryName;

  CategoryPageeeee({required this.categoryName});

  final RecipesController categoryController = Get.put(RecipesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Page',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: categoryController.filterRecipesByCategory(categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Category Name: $categoryName",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: categoryController.RecipesByCategory.length,
                  itemBuilder: (context, index) {
                    var recipe = categoryController.RecipesByCategory[index];

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          recipe.RecipeName ?? '',
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(
                          recipe.Area ?? '',  // Add more details if needed
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(recipe.RecipeImage ?? ''),
                        ),
                        // Add more details if needed
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
