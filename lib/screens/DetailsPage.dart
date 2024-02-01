import 'package:flutter/material.dart';
import '../controllers/IngredientsController.dart';
import '../models/RecipesModel.dart';
import 'package:get/get.dart';


class RecipeDetailsScreen extends StatelessWidget {
  final RecipesModel recipe;
  final IngredientsController controller = Get.put(IngredientsController());

  RecipeDetailsScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    controller.getRecipeIngredients(recipe.RecipeName);

    // body: Column(
    //   children: [
    // Expanded(
    // child: SingleChildScrollView(
    // child: Column(
    // children: [
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange[300],
          elevation: 0.0,
          title: Text(
            recipe.RecipeName,
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(child: Text('Ingredients: ',style: TextStyle(fontFamily: 'Poppins',fontSize: 30),)),
                    SizedBox(height: 20),

                    GetBuilder<IngredientsController>(
                      builder: (val) {
                        return Column(mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 300,
                              color: Colors.white,
                              child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                                itemCount: val.oneRecipeIngredients.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Text(val.oneRecipeIngredients[index].IngredientName!,style: TextStyle(fontSize: 25));
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),


                    SizedBox(height: 20),
                    Center(child: Text('Procedure: ',style: TextStyle(fontFamily: 'Poppins',fontSize: 30),)),
                    Text('${recipe.Procedure}',style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
            ]
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
// recipes_controller.dart
