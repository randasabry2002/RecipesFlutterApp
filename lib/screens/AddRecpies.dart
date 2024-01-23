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

  var _firestor = FirebaseFirestore.instance;

  addRecipe() {
    _firestor.collection("Recipes").add({
      "RecipeName": "Spicy Penne",
      "Area": "Italian",
      "Category": "Vegetarian",
      "RecipeDate": DateTime.now(),
      "Procedure": "Bring a large pot of water to a boil. Add kosher salt to the boiling water, then add the pasta. Cook according to the package instructions, about 9 minutes. In a large skillet over medium-high heat, add the olive oil and heat until the oil starts to shimmer. Add the garlic and cook, stirring, until fragrant, 1 to 2 minutes. Add the chopped tomatoes, red chile flakes, Italian seasoning and salt and pepper to taste. Bring to a boil and cook for 5 minutes. Remove from the heat and add the chopped basil. Drain the pasta and add it to the sauce. Garnish with Parmigiano-Reggiano flakes and more basil and serve warm.",
      "RecipeImage": "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg",
      "RecipeVideo": "https://www.youtube.com/watch?v=1IszT_guI08",
      "Tags": "Pasta,Curry",
    });
  }

  @override
  Widget build(BuildContext context) {
    addRecipe();

    return Scaffold(backgroundColor: Colors.pink,);
  }

}