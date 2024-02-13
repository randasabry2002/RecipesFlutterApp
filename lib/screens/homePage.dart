import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/RecipesController.dart';
import '../controllers/SearchController.dart';
import '../controllers/UsersController.dart';
import '../models/RecipesModel.dart';
import '../widgets/RecipeItem.dart';
import '../widgets/categoryitem.dart';
import 'DetailsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final RecipesController controller = Get.put(RecipesController());
  final UsersController usersController = Get.put(UsersController());
  final SearchText = TextEditingController();
  final SearchRecipeController searchController = Get.put(SearchRecipeController());
  RxBool isSearching = false.obs;
  String? userName;
  @override
  Widget build(BuildContext context) {
    // Fetch recipes from the controller
    controller.getRecipes();
    SharedPreferences.getInstance().then((value) {
      userName = value.getString("userName").toString();
      usersController.getAllFavRecipes(userName!);
    });

    // usersController.getUserByEmail(_auth.currentUser!.email!);

    return WillPopScope(
        onWillPop: () async {
      // Exit the application when back button is pressed
      SystemNavigator.pop();
      return true;
    },
    child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Container(
            height: 300, // Set the desired height
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/religious-meal.png'), // Replace with your image path
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 50),

                // Search Container
                // Container for show search bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),  // Set horizontal padding
                  decoration: BoxDecoration(
                    color: Colors.grey[300],  // Set background color
                    borderRadius: BorderRadius.circular(8.0),  // Set border radius
                  ),
                  child: Row(//show icon of search and write the thing you search about
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),  // Set horizontal padding
                          child: TextField(
                            controller: SearchText, // Attach a TextEditingController for handling text input
                            onEditingComplete: () {
                              print("Done button pressed!");
                              SearchText.text=SearchText.text.trim();
                              if (SearchText.text != "") {
                                isSearching.value = true;
                              }
                            },
                            onChanged: (val) {
                              // Update search text and clear results when text is empty
                              SearchText.text = val;
                              if (val == "") {
                                isSearching.value = false;
                                SearchText.clear();
                              }
                            },
                            style: TextStyle(color: Colors.black),  // Set text color
                            decoration: InputDecoration(
                              prefixIcon: InkWell(
                                child: Icon(Icons.search, color: Colors.grey[700]),  // Search icon
                                onTap: () {
                                  // Start searching when the search icon is tapped
                                  SearchText.text=SearchText.text.trim();
                                  if (SearchText.text != "") {
                                    isSearching.value = true;
                                  }
                                },
                              ),
                              //clear the data from the bar
                              suffixIcon: InkWell(
                                child: Icon(Icons.cancel, color: Colors.grey[700]),  // Cancel icon
                                onTap: () {
                                  // Clear search text and results when cancel icon is tapped
                                  isSearching.value = false;
                                  SearchText.clear();
                                },
                              ),
                              hintText: 'Search...',  // Placeholder text
                              hintStyle: TextStyle(color: Colors.grey[700]),  // Placeholder text color
                              border: InputBorder.none,  // Remove input border
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 190),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Obx is an Observer widget that reacts to changes in the specified observable variables
                        Obx(() {
                          // Check if searching is active
                          if (isSearching.value) {
                            // Get search results based on the entered text
                            searchController.getSearchRecipes(SearchText.text.toString());

                            // Check if there are no search results
                            if (searchController.searchResult.length == 0) {
                              // Display a message when there are no search results
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 50),
                                child: const Center(
                                  child: Text("No Results", style: TextStyle(fontSize: 20, color: Colors.black)),
                                ),
                              );
                            } else {
                              // Display search results using GetBuilder to react to changes in SearchRecipeController
                              return GetBuilder<SearchRecipeController>(
                                builder: (val) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      // List of search results
                                      Container(
                                        height: 700,
                                        color: Colors.white,
                                        child: ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: val.searchResult.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            var recipe = val.searchResult[index];

                                            return GestureDetector(
                                              onTap: () {
                                                // Navigate to recipe details when a search result is tapped
                                                Get.to(() => RecipeDetailsScreen(recipe: recipe));
                                              },
                                              child: Card(
                                                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                elevation: 5,
                                                child: ListTile(
                                                  title: Text(
                                                    recipe.RecipeName ?? '',
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                  ),
                                                  subtitle: Text(
                                                    recipe.Area ?? '',
                                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                                  ),
                                                  leading: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: NetworkImage(recipe.RecipeImage ?? ''),
                                                  ),
                                                ),
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
                          } else {
                            // Default view when not searching

                            // Display categories section
                            return Column(
                              children: [
                                // Text(
                                //   "Our Category ",
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 19,
                                //     color: Colors.black,
                                //   ),
                                // ),
                                // StreamBuilder to react to changes in the Firestore collection
                                StreamBuilder<QuerySnapshot>(
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<CategoryItem> Categories = [];
                                      var responseCategories = snapshot.data!.docs;
                                      List<String> s = [];
                                      for (var i = 0; i < responseCategories.length; i++) {
                                        s.add(responseCategories[i].get('Category'));
                                      }
                                      var distinctCategoriesNames = s.toSet().toList();

                                      for (var i = 0; i < distinctCategoriesNames.length; i++) {
                                        Categories.add(CategoryItem(
                                          nameCategory: distinctCategoriesNames[i],
                                        ));
                                      }

                                      // Display categories using a horizontal ListView
                                      return Container(
                                        margin: EdgeInsets.symmetric(vertical: 20.0),
                                        height: 100.0,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: false,
                                          physics: BouncingScrollPhysics(),
                                          children: Categories,
                                        ),
                                      );
                                    } else {
                                      // Display a loading spinner while waiting for data
                                      return Center(
                                        child: SpinKitWave(
                                          color: Colors.black,
                                          size: 50.0,
                                        ),
                                      );
                                    }
                                  },
                                  stream: _firestore.collection("Recipes").snapshots(),
                                ),

                                // Display meals section
                                Text(
                                  "Meals",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10,),

                                // Display meals using GetBuilder to react to changes in RecipesController
                                GetBuilder<UsersController>(
                                  builder: (val) {
                                    return Container(
                                      height: 300,
                                      color: Colors.white,
                                      child: ListView.builder(
                                        itemCount: val.UserRecipes.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          RecipesModel recipe = val.UserRecipes[index];
                                          //هيبعتها لل فاف كونترولر يدور هيا فيف ولا لا
                                          // usersController.findIfFav(usersController.userByEmail.value.UserName!,recipe);
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
        ],
      ),
    ));
  }
}

