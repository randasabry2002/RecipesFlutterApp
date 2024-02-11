import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/IngredientsController.dart';
import '../controllers/ShoppingListController.dart';
import '../models/RecipesModel.dart';

class RecipeDetailsScreen extends StatefulWidget {
// Declare variable recipe to access the name and image of the meal
  final RecipesModel recipe;

  RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  final IngredientsController controller = Get.put(IngredientsController());
  final ShoppingListController shoppingListController = Get.put(
      ShoppingListController());
  String? userName;

// Define a list of boolean flags to track whether each ingredient has been added
  List<bool> isIngredientAddedList = [];

  @override
  void initState() {
    super.initState();
    initializeIsIngredientAddedList();
  }

  void initializeIsIngredientAddedList() {
// Initialize the list with false values for each ingredient
    controller.oneRecipeIngredients.forEach((ingredient) {
      isIngredientAddedList.add(false);
    });
  }

  @override
  Widget build(BuildContext context) {
// Fetch recipe ingredients using the controller
    controller.getRecipeIngredients(widget.recipe.RecipeName!);

    SharedPreferences.getInstance().then((value) {
      userName = value.getString("userName").toString();
    });

// Scaffold widget for the overall screen structure
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    widget.recipe.RecipeImage!,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Center(
                    child: Text(
                      widget.recipe.RecipeName!,
                      style: TextStyle(fontFamily: 'Poppins',
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
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
                        const Text(
                          'Ingredients:',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 30),
                        ),
                        SizedBox(height: 20),
                        GetBuilder<IngredientsController>(
                          builder: (val) {
// Initialize the list here
                            initializeIsIngredientAddedList();
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: val.oneRecipeIngredients.length,
                              itemBuilder: (context, index) {
                                shoppingListController.inShoppingListOrNot(
                                    userName!, val.oneRecipeIngredients[index]
                                    .IngredientName!);

                                return ListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            val.oneRecipeIngredients[index]
                                                .IngredientName!,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Spacer(),
// Show the minus icon only if the ingredient has been added
                                          if (isIngredientAddedList.length >
                                              index &&
                                              isIngredientAddedList[index])
                                            IconButton(
                                              onPressed: () {
                                                shoppingListController
                                                    .deleteIngredientToShoppingList(
                                                    userName!);
                                                setState(() {
// Update the flag to false when the minus icon is clicked
                                                  isIngredientAddedList[index] =
                                                  false;
                                                });
                                              },
                                              icon: Icon(Icons.remove,color: Colors.red,),
                                            ),
// Show the add icon and update the flag when clicked
                                          IconButton(
                                            onPressed: () {
                                              shoppingListController
                                                  .addIngredientToShoppingList(
                                                  userName!, val
                                                  .oneRecipeIngredients[index]
                                                  .IngredientName!);
                                              setState(() {
// Update the flag to true when the add icon is clicked
                                                isIngredientAddedList[index] =
                                                true;
                                              });
                                            },
                                            icon: Icon(Icons.add,color: Colors.green,),
                                          ),
                                          Icon(Icons.add_shopping_cart_rounded),
                                        ],
                                      ),
                                      Text(
                                        val.oneRecipeIngredients[index].Amount!,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ],
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
                              '${widget.recipe.Procedure}',
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
      ),
    );
  }

}
