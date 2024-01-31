import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/RecipesModel.dart';

class RecipesController extends GetxController {
  var _firestor = FirebaseFirestore.instance;
  var Recipes = <RecipesModel>[].obs;
  var favRecipes = <RecipesModel>[].obs;
  var RecipesByCategory = <RecipesModel>[].obs;


  Future<void> getRecipes() async {
    var response = _firestor.collection("Recipes");

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await response.get();

    Recipes.value = querySnapshot.docs.map((doc) {
      Timestamp recipeDate = doc.get('RecipeDate');
      // print(doc.id);
      return RecipesModel(
        Recipeid: doc.id,
        RecipeName: doc.get('RecipeName'),
        Category: doc.get('Category'),
        Area: doc.get('Area'),
        Procedure: doc.get('Procedure'),
        RecipeImage: doc.get('RecipeImage'),
        RecipeVideo: doc.get('RecipeVideo'),
        Tags: doc.get('Tags'),
        Fav: doc.get('Fav'),
        InShoppingList: doc.get('InShoppingList'),
        RecipeDate: recipeDate.toDate(),
      );
    }).toList();
    update();
  }

  filterRecipesByCategory(String categoryName) async {
    await getRecipes();
    RecipesByCategory.clear();
    if (Recipes.isNotEmpty) {
      for (var recipe in Recipes) {
        if (recipe.Category == categoryName) {
          RecipesByCategory.add(recipe);
        }
      }
    }
    if (Recipes.isNotEmpty) {
      for(var i in RecipesByCategory)
        print(i.RecipeName.toString());
    } else {
      print("Categories list is empty");
    }
    update();
  }

  getFavs() async {
    favRecipes.clear();
    await getRecipes();
    for(var Resipe in Recipes){
      if(Resipe.Fav == true){
        favRecipes.add(Resipe);
      }
    }
    update();
  }

  changeFav(String recipeId,bool newFav) async {
    await FirebaseFirestore.instance.collection('Recipes').doc(recipeId).update({'Fav': newFav});
    print("Fav updated  "+ newFav.toString());
    // update();
    await getFavs();
    update();

  }


}
