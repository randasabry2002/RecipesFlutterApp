import 'package:flutter/material.dart';
import '../controllers/RecipesController.dart';
import '../models/RecipesModel.dart';
import 'RecipeItem.dart';
import 'categoryItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  var _firestor = FirebaseFirestore.instance;
  final RecipesController controller = Get.put(RecipesController());

  @override
  Widget build(BuildContext context) {
    controller.getResipes();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home page',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[700]),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
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
                  const Text("Category Section",
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

                  const Text("meals Section",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,)
                    ,),

                  GetBuilder<RecipesController>(
                    builder: (val) {
                      return Column(
                        children: [
                          Container(
                            height: 300,
                            color: Colors.orange[300],
                            child: ListView.builder(
                              itemCount: val.Resipes.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                RecipesModel recipe = val.Resipes[index];
                                return RecipeItem(
                                  recipe: recipe,
                                  onFavoritePressed: () {
                                    recipe.Fav = !recipe.Fav;
                                    val.update();
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
