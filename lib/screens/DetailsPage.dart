import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/IngredientsController.dart';
import '../models/RecipesModel.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final RecipesModel recipe;
  final IngredientsController controller = Get.put(IngredientsController());

  RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getRecipeIngredients(recipe.RecipeName);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        elevation: 0.0,
        title: Text(
          recipe.RecipeName,
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(recipe.RecipeImage),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ingredients:',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 30),
                      ),
                      SizedBox(height: 20),
                      GetBuilder<IngredientsController>(
                        builder: (val) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: val.oneRecipeIngredients.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  val.oneRecipeIngredients[index].IngredientName!,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Procedure:',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 30),
                      ),
                      SizedBox(height: 20),
                      GetBuilder<IngredientsController>(
                        builder: (val) {
                          return Text(
                            '${recipe.Procedure}',
                            style: TextStyle(fontSize: 20),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
