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

  final ShoppingListController shoppingListController = Get.put(ShoppingListController());

  String? userName;

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
          // Padding around the entire body
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            // SingleChildScrollView allows scrolling when the content overflows
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display recipe image in a rounded rectangle
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    widget.recipe.RecipeImage!,
                    width: double.infinity,
                    fit: BoxFit.fill, // Cover the entire container

                    // height: 300.0, // Set a suitable height for the image
                  ),
                ),
                SizedBox(height: 20), // Add space between image and text

                // Display recipe name
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Center(
                    child: Text(//show the name of recipe bellow the photo
                      widget.recipe.RecipeName!,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 21, fontWeight: FontWeight.w900, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Card containing ingredients
                Card(
                  // Set the elevation to 5 for a subtle shadow effect
                  elevation: 5,//كلما زادت القيمة، كان تأثير الظل أكثر وضوحًا.
                  child: Padding(
                    // Apply padding to the entire content within the card
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display the title "Ingredients" with a specific text style
                        const Text(
                          'Ingredients:',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 30),
                        ),
                        SizedBox(height: 20),  // Add a vertical spacing of 20 units

                        // Use GetBuilder to dynamically display ingredients based on the controller's state
                        GetBuilder<IngredientsController>(
                          builder: (val) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: val.oneRecipeIngredients.length,
                              itemBuilder: (context, index) {
                                shoppingListController.inShoppingListOrNot(userName!,val.oneRecipeIngredients[index].IngredientName!);
                                // print(shoppingListController.isInShoppingList.value);
                                // Build a ListTile for each ingredient with a specific font size
                                return ListTile(
                                  // if the Ingredients not null that come from firebase show it
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            val.oneRecipeIngredients[index].IngredientName!,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Spacer(),
                                          // !shoppingListController.isInShoppingList.value?
                                               IconButton(onPressed: (){
                                                shoppingListController.addIngredientToShoppingList(userName!,val.oneRecipeIngredients[index].IngredientName!);
                                                setState(() {
                                                });
                                                }, icon: Icon(Icons.add)),
                                              // : IconButton(onPressed: (){
                                              //   shoppingListController.deleteIngredientToShoppingList(userName!,val.oneRecipeIngredients[index].IngredientName!);
                                              //   setState(() {
                                              //   });
                                              //   }, icon: Icon(Icons.minimize)),
                                          Icon(Icons.add_shopping_cart_rounded),
                                        ],
                                      ),
                                      // Check if Amount is not null before displaying it
                                      Text(
                                        val.oneRecipeIngredients[index].Amount!,
                                        style: TextStyle(fontSize: 16, color: Colors.grey),
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

                // Card containing recipe procedure
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
                        // Display recipe procedure text
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
