import 'package:flutter/material.dart';
import '../controllers/RecipesController.dart';
import '../controllers/SearchController.dart';
import '../models/RecipesModel.dart';
import '../widgets/RecipeItem.dart';
import '../widgets/categoryitem.dart';
import 'DetailsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatelessWidget {
  final _firestor = FirebaseFirestore.instance;
  final RecipesController controller = Get.put(RecipesController());
  final SearchText = TextEditingController();
  final SearchRecipeController searchController = Get.put(SearchRecipeController());
  RxBool isSearching = false.obs;

  @override
  Widget build(BuildContext context) {
    controller.getRecipes();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Home page',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.orange[300],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //Search Container
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                controller: SearchText,
                                onChanged: (val){
                                  SearchText.text=val;
                                  if(val=="")
                                    {
                                      isSearching.value = false; // Update the search state
                                      SearchText.clear();
                                    }
                                },
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: InkWell(child: Icon(Icons.search, color: Colors.grey[700]),
                                    onTap: (){
                                    if(SearchText.text!="") {
                                      isSearching.value = true; // Update the search state
                                      print("Search");
                                    }
                                    },),
                                  suffixIcon: InkWell(child: Icon(Icons.cancel, color: Colors.grey[700]),
                                      onTap: (){
                                        isSearching.value = false; // Update the search state
                                        SearchText.clear();
                                        print("Cancel");
                                      },),
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    Obx(() {
                      if (isSearching.value) {
                        searchController.getSearchRecipes(SearchText.text.toString());
                        if(searchController.searchResult.length==0)
                          {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 50),
                              child: const Center(child: Text("No Results",style: TextStyle(fontSize: 20),)),
                            );
                          }
                        else
                          {
                            return GetBuilder<SearchRecipeController>(
                              builder: (val) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      height: 700,
                                      color: Colors.white,
                                      child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                                        itemCount: val.searchResult.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          // return Text(val.searchResult[index].RecipeName,style: TextStyle(fontSize: 25));
                                          var recipe = val.searchResult[index];

                                          return Card(
                                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                            elevation: 5,
                                            child: ListTile(
                                              title: Text(
                                                recipe.RecipeName ?? '',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              subtitle: Text(
                                                recipe.Area ?? '',  // Add more details if needed
                                                style: TextStyle(fontSize: 14, color: Colors.grey),
                                              ),
                                              leading: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(recipe.RecipeImage ?? ''),
                                              ),
                                              // Add more details if needed
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                      }
                      else{
                        return Column(
                          children: [
                            const Text(
                              "Category Section",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<CategoryItem> Categories = [];
                                  var responseCategories = snapshot.data!.docs;
                                  // debugPrint(responseCategories[0].get('Category').toString()+'dataaa');
                                  List<String> s = [];
                                  for (var i = 0; i < responseCategories.length; i++) {
                                    s.add(responseCategories[i].get('Category'));
                                  }
                                  var distinctCategoriesNames = s.toSet().toList();
                                  // print(distinctCategoriesNames);

                                  for (var i = 0;
                                  i < distinctCategoriesNames.length;
                                  i++) {
                                    Categories.add(CategoryItem(
                                      nameCategory: distinctCategoriesNames[i],
                                    ));
                                  }

                                  return Container(
                                      margin: EdgeInsets.symmetric(vertical: 20.0),
                                      height: 100.0,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: false,
                                        physics: BouncingScrollPhysics(),
                                        // reverse: true,
                                        children: Categories,
                                      ));
                                } else {
                                  return const Center(
                                    child: SpinKitWave(
                                      color: Colors.black,
                                      size: 50.0,
                                    ),
                                  );
                                }
                              },
                              stream: _firestor.collection("Recipes").snapshots(),
                            ),
                            ///
                            const Text(
                              "meals Section",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            GetBuilder<RecipesController>(
                              builder: (val) {
                                return Column(
                                  children: [
                                    Container(
                                      height: 300,
                                      color: Colors.white,
                                      child: ListView.builder(
                                        itemCount: val.Recipes.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          RecipesModel recipe = val.Recipes[index];
                                          return RecipeItem(
                                            recipe: recipe,
                                            onFavoritePressed: () async {
                                              await val.changeFav(
                                                  recipe.Recipeid, !recipe.Fav);
                                              // recipe.Fav = !recipe.Fav;
                                              val.update();
                                            },
                                            onTap: () {
                                              // Navigate to details page
                                              // RecipesController.to.navigateToRecipeDetailsScreen(recipe);
                                              Get.to(() =>
                                                  RecipeDetailsScreen(recipe: recipe));
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      }
                    }),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
