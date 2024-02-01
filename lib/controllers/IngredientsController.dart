import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/RecipeIngredientsModel.dart';


class IngredientsController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

  var Recipes_Ingredients = <RecipeIngredientsModel>[].obs;
  var oneRecipeIngredients = <RecipeIngredientsModel>[].obs;


  Future<void> getRecipeIngredients(String RecipeName) async {
    var response = _firestore.collection("Recipe_Ingredients");

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await response.get();

    Recipes_Ingredients.value = querySnapshot.docs.map((doc) {
      return RecipeIngredientsModel(
          RecipeName: doc.get("Recipe_Name"),
          IngredientName: doc.get("Ingredient_Name"),
          Amount: doc.get("Amount"),
      );
    }).toList();

    oneRecipeIngredients.clear();
    for(var i=0;i<Recipes_Ingredients.length;i++){
      if(Recipes_Ingredients[i].RecipeName==RecipeName)
        {
          oneRecipeIngredients.add(Recipes_Ingredients[i]);
        }
    }

    update();
  }

}