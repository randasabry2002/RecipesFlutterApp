import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRecpies extends StatefulWidget{
  @override
  State<AddRecpies> createState() {
    return AddRecpiesState();
  }
  
}

class AddRecpiesState extends State<AddRecpies>{

  var _firestore = FirebaseFirestore.instance;


  addIngredients(){
    // _firestore.collection("Ingredients").add({
    //   "Ingredient_Name": "",
    //   "Category": "",
    // });
  }
  
  addRecipe() {
    // _firestore.collection("Recipes").add({
    //   "RecipeName": "Smashed Watermelon Margarita",
    //   "Area": "",
    //   "Category": "Cocktail, Alcoholic",
    //   "RecipeDate": DateTime(2023,08,18,14,42,59),
    //   "Procedure": "In a mason jar muddle the watermelon and 5 mint leaves together into a puree and strain. Next add the grapefruit juice, juice of half a lime and the tequila as well as some ice. Put a lid on the jar and shake. Pour into a glass and add more ice. Garnish with fresh mint and a small slice of watermelon.",
    //   "RecipeImage": "https://www.thecocktaildb.com/images/media/drink/dztcv51598717861.jpg",
    //   "RecipeVideo": "",
    //   "Tags": "",
    //   "Fav": false,
    //   "InShoppingList": false,
    // });
  }

  addRecipeIngredients() {

    //  _firestore.collection("Recipe_Ingredients").add({
    //   "Recipe_Name": "Smashed Watermelon Margarita",
    //   "Ingredient_Name": "Watermelon",
    //   "Amount": "1/2 cup",
    // });
      }

  @override
  Widget build(BuildContext context) {

    // print('callTime');

    return Scaffold(backgroundColor: Colors.pink,);
  }

}