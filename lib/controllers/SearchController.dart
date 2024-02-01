import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/RecipeIngredientsModel.dart';
import '../models/RecipesModel.dart';
import 'RecipesController.dart';

class SearchRecipeController extends GetxController {
  var _firestor = FirebaseFirestore.instance;
  final RecipesController controller = Get.put(RecipesController());
  var searchRecipesResult = <RecipeIngredientsModel>[].obs;
  var searchRecipesIngredients = <RecipeIngredientsModel>[].obs;
  var searchResult = <RecipesModel>[].obs;


    getSearchRecipes(String searchTxt) async {
    var response = _firestor.collection("Recipe_Ingredients");

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await response.get();

    searchRecipesIngredients.clear();
    searchRecipesIngredients.value = querySnapshot.docs.map((doc) {
      return RecipeIngredientsModel(
        RecipeName: doc.get("Recipe_Name"),
        IngredientName: doc.get("Ingredient_Name"),
        Amount: doc.get("Amount"),
      );
    }).toList();

    searchRecipesResult.clear();
    for(var i=0;i<searchRecipesIngredients.length;i++){
      if(searchRecipesIngredients[i].RecipeName==searchTxt)
      {
        print("it is a Recipe");
        searchRecipesResult.add(searchRecipesIngredients[i]);
        break;
      }
      else if(searchRecipesIngredients[i].IngredientName==searchTxt)
        {
          print("it is an Ingredients");
          searchRecipesResult.add(searchRecipesIngredients[i]);
        }
    }
    print(searchRecipesResult.length.toString()+" length");
    searchResult.clear();
    for(var i=0;i<searchRecipesResult.length;i++){
      await controller.getRecipeByName(searchRecipesResult[i].RecipeName!);
      print(controller.RecipesByName[0].RecipeName);
      searchResult.add(controller.RecipesByName[0]);
      // print(controller.RecipesByName[0].RecipeName+ " searchResult");
    }


    update();
  }


}