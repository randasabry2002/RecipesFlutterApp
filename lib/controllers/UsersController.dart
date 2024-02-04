import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/FavoritesModel.dart';
import '../models/RecipesModel.dart';
import '../models/UserModel.dart';
import 'RecipesController.dart';

class UsersController extends GetxController {
  var _firestor = FirebaseFirestore.instance;
  var Users = <UserModel>[].obs;
  var userByEmail=UserModel().obs;
  var AllFavorites=<FavoritesModel>[].obs;
  var UserRecipes=<RecipesModel>[].obs;
  var OneUserFavorits=<RecipesModel>[].obs;
  var fav=false.obs;
  var favOrNotFavRecipes = <RecipesModel>[].obs;
  final RecipesController controller = Get.put(RecipesController());


  Future<void> getUsers() async {
    var response = _firestor.collection("Users");

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await response.get();

    Users.value = querySnapshot.docs.map((doc) {
      return UserModel(
        UserName: doc.get('UserName'),
        Email: doc.get('Email'),
        Password: doc.get('Password'),
        ProfileImagePath: doc.get('ProfileImagePath'),
      );
    }).toList();
    update();
  }

  getUserByEmail(String email) async {
    await getUsers();

    for(var user in Users){
      if(user.Email==email){
        userByEmail.value =user;
        // print(userByEmail.value.UserName.toString() + "   UserName");
      }
    }
    update();
  }

  /// ///////////////////////////////////////////////////////////

  getAllFavRecipes(String userName) async {
    UserRecipes.clear();
    await controller.getRecipes();
    var response = _firestor.collection("Favorites");

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await response.get();

    AllFavorites.value = await querySnapshot.docs.map((doc) {
      return FavoritesModel(
        DocId: doc.id,
        UserName: doc.get('UserName'),
        RecipeName: doc.get('RecipeName'),
      );
    }).toList();

    bool favo=false;

    for(var i=0;i<controller.Recipes.length;i++){
      favo=false;
      for(var j=0;j<AllFavorites.length;j++){
        if(controller.Recipes[i].RecipeName==AllFavorites[j].RecipeName && AllFavorites[j].UserName==userName){
          favo=true;
        }
      }
      controller.Recipes[i].Fav=favo;
      // print(controller.Recipes[i].Fav);
      UserRecipes.add(controller.Recipes[i]);
    }
    update();
  }

  gitFavRecipesOfOneUser(String userName) async {
    OneUserFavorits.clear();
    await getAllFavRecipes(userName);
    for(var i=0;i<UserRecipes.length;i++){
      if(UserRecipes[i].Fav==true){
        OneUserFavorits.add(UserRecipes[i]);
      }
    }
    update();
  }

  addFav(String userName,String recipeName) async {

    try {
      // Add a new document with auto-generated ID
      await _firestor.collection("Favorites").add({
        "UserName": userName,
        "RecipeName": recipeName,
      });
      print('Document added successfully');
    } catch (e) {
      print('Error adding document: $e');
    }
    // await getAllFavRecipes(userName);
    for(var i=0;i<UserRecipes.length;i++){
      if(UserRecipes[i].RecipeName==recipeName){
        UserRecipes[i].Fav= !UserRecipes[i].Fav!;
      }
    }
    update();
  }

  deleteFav(String userName,String recipeName) async {
    String docId="";
    await getAllFavRecipes(userName);

    for(var i=0;i<AllFavorites.length;i++) {
      if(AllFavorites[i].RecipeName==recipeName && AllFavorites[i].UserName==userName)
        {
          docId=AllFavorites[i].DocId!;
        }
    }

    try {
      // Delete the document
      await _firestor.collection("Favorites").doc(docId).delete();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
    // favOrNotFavRecipe.value.Fav=false;
    await getAllFavRecipes(userName);
    await gitFavRecipesOfOneUser(userName);
    update();
  }

  }
