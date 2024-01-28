import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/RecipesModel.dart';

class RecipesController extends GetxController {
  var _firestor = FirebaseFirestore.instance;

  var Resipes = <RecipesModel>[].obs;

  Future<void> getResipes() async {
    var response = _firestor.collection("Recipes");

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await response.get();


    Resipes.value = querySnapshot.docs.map((doc) {
      Timestamp recipeDate = doc.get('RecipeDate');
      return RecipesModel(
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

    // print(Resipes[1].RecipeName.toString());
  }
}
