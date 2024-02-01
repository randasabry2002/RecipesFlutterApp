import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/RecipesModel.dart';
import '../screens/DetailsPage.dart';
// صفحة تفاصيل الوصفة

class RecipesListPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Recipes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<RecipesModel> recipes = snapshot.data!.docs.map((doc) {
            Timestamp recipeDate = doc.get('RecipeDate');
            return RecipesModel(
              Recipeid: doc.id,
              RecipeName: doc.get('RecipeName'),
              Area: doc.get('Area'),
              Category: doc.get('Category'),
              Procedure: doc.get('Procedure'),
              RecipeImage: doc.get('RecipeImage'),
              RecipeVideo: doc.get('RecipeVideo'),
              Tags: doc.get('Tags'),
              Fav: doc.get('Fav'),
              InShoppingList: doc.get('InShoppingList'),
              RecipeDate: recipeDate.toDate(),
            );
          }).toList();

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(recipes[index].RecipeName),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailsScreen(recipe: recipes[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
