import 'package:flutter/material.dart';
import '../controllers/UsersController.dart';
import '../models/RecipesModel.dart';
import '../widgets/RecipeItem.dart';
import 'DetailsPage.dart';
import 'homePage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/RecipesController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatelessWidget {
  final RecipesController controller = Get.put(RecipesController());
  final UsersController usersController = Get.put(UsersController());
  String? userName;

  @override
  Widget build(BuildContext context) {
    controller.getFavs();
    SharedPreferences.getInstance().then((value) {
      userName = value.getString("userName").toString();
      usersController.gitFavRecipesOfOneUser(userName!);
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites',
            style: TextStyle(fontFamily: 'Poppins',color: Colors.white,fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: GetBuilder<UsersController>(
                    builder: (val) {
                      return Container(
                        height: 720,
                        // color: Colors.orange[300],
                        child: ListView.builder(
                          itemCount: val.OneUserFavorits.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            RecipesModel recipe = val.OneUserFavorits[index];
                            return RecipeItem(
                              recipe: recipe,
                              onFavoritePressed: () async {
                                if(recipe.Fav==false){
                                  await val.addFav(userName!, recipe.RecipeName!);
                                }
                                else{
                                  await val.deleteFav(userName!, recipe.RecipeName!);
                                }
                                val.update();
                              },
                              onTap: () {
                                // Navigate to recipe details when a meal is tapped
                                Get.to(() => RecipeDetailsScreen(recipe: recipe));
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
