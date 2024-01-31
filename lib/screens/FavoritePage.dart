import 'package:flutter/material.dart';
import '../models/RecipesModel.dart';
import 'RecipeItem.dart';
import 'homePage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/RecipesController.dart';

class FavoritePage extends StatelessWidget {
  final RecipesController controller = Get.put(RecipesController());

  @override
  Widget build(BuildContext context) {
    controller.getFavs();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Page',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.orange[300],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: GetBuilder<RecipesController>(
                  builder: (val) {
                    return Container(
                      height: 720,
                      // color: Colors.orange[300],
                      child: ListView.builder(
                        itemCount: val.favRecipes.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          RecipesModel recipe = val.favRecipes[index];
                          return RecipeItem(
                            recipe: recipe,
                            onFavoritePressed: () async {
                              await val.changeFav(recipe.Recipeid, !recipe.Fav);
                              val.update();
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
    );

    // return SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Favorite Page'),
    //     ),
    //     body: Column(
    //       children: [
    //         Expanded(
    //           child: SingleChildScrollView(
    //             child: Column(
    //               children: [
    //                 GetBuilder<RecipesController>(
    //                 builder: (val) {
    //                   return Column(
    //                     children: [
    //                       Container(
    //                         height: double.maxFinite,
    //                         color: Colors.orange[300],
    //                         child: ListView.builder(
    //                           itemCount: val.favRecipes.length,
    //                           scrollDirection: Axis.vertical,
    //                           itemBuilder: (context, index) {
    //                             RecipesModel recipe = val.favRecipes[index];
    //                             return RecipeItem(
    //                               recipe: recipe,
    //                               onFavoritePressed: () async {
    //                                 await val.changeFav(
    //                                     recipe.Recipeid, !recipe.Fav);
    //                                 // recipe.Fav = !recipe.Fav;
    //                                 val.update();
    //                               },
    //                             );
    //                           },
    //                         ),
    //                       ),
    //                     ],
    //                   );
    //                 },
    //               ),
    //   ]
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
