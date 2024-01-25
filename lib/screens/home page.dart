

import 'package:flutter/material.dart';

import 'RecipeItem.dart';
import 'categoruandrecipe.dart';
import 'categoryItem.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  List<Recipe> recipes = [
    Recipe(name: 'Spaghetti', imageUrl: 'assets/images/spaghetti_image.jpg'),
    Recipe(name: 'Pizza', imageUrl: 'assets/images/pizza.png'),
    Recipe(name: 'Burger', imageUrl: 'assets/images/burger_image.jpg'),
    Recipe(name: 'Salad', imageUrl: 'assets/images/salad.png'),
    Recipe(name: 'Spaghetti', imageUrl: 'assets/images/spaghetti_image.jpg'),
    Recipe(name: 'Pizza', imageUrl: 'assets/images/pizza.png'),
    Recipe(name: 'Burger', imageUrl: 'assets/images/burger_image.jpg'),
    Recipe(name: 'Salad', imageUrl: 'assets/images/salad.png'),

  ];

  List<Category> categories = [
    Category(name: 'Spaghetti', imageUrl: 'assets/images/spaghetti_image.jpg'),
    Category(name: 'Pizza', imageUrl: 'assets/images/pizza.png'),
    Category(name: 'Burger', imageUrl: 'assets/images/burger_image.jpg'),
    Category(name: 'Salad', imageUrl: 'assets/images/salad.png'),
    Category(name: 'Spaghetti', imageUrl: 'assets/images/spaghetti_image.jpg'),
    Category(name: 'Pizza', imageUrl: 'assets/images/pizza.png'),
    Category(name: 'Burger', imageUrl: 'assets/images/burger_image.jpg'),
    Category(name: 'Salad', imageUrl: 'assets/images/salad.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: SingleChildScrollView(
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
            SizedBox(height: 20),
            Container(
              height: 300,
              color: Colors.orange[300],
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Category category = categories[index];
                  return CategoryItem(
                    nameCategory: category.name,
                    imageUrlCategory: category.imageUrl,
                  );
                },
              ),
            ),

            SizedBox(height: 20),
            Container(
              height: 300,
              color: Colors.orange[300],
              child: ListView.builder(
                itemCount: recipes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Recipe recipe = recipes[index];
                  return RecipeItem(
                    recipe: recipe,
                    onFavoritePressed: () {
                      setState(() {
                        recipe.isFavorite = !recipe.isFavorite;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}














// import 'package:flutter/material.dart';
//
// import 'RecipeItem.dart';
// import 'categoruandrecipe.dart';
// import 'categoryItem.dart';
//
// // StatefulWidget for the home screen
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() {
//     return HomeScreenState();
//   }
// }
//
// // State class for the home screen
// class HomeScreenState extends State<HomeScreen> {
//   // List of Recipe objects representing recipes
//   List<Recipe> recipes = [
//     Recipe(name: 'Spaghetti', imageUrl: 'assets/images/spaghetti_image.jpg'),
//     Recipe(name: 'Pizza', imageUrl: 'assets/images/pizza.png'),
//     Recipe(name: 'Burger', imageUrl: 'assets/images/burger_image.jpg'),
//     Recipe(name: 'Salad', imageUrl: 'assets/images/salad.png'),
//     Recipe(name: 'Spaghetti', imageUrl: 'assets/images/spaghetti_image.jpg'),
//     Recipe(name: 'Pizza', imageUrl: 'assets/images/pizza.png'),
//     Recipe(name: 'Burger', imageUrl: 'assets/images/burger_image.jpg'),
//     Recipe(name: 'Salad', imageUrl: 'assets/images/salad.png'),
//   ];
//
//   // List of Category objects representing categories
//   List<Category> categories = [
//     Category(name: 'Spaghetti', imageUrl: 'assets/images/spaghetti_image.jpg'),
//     Category(name: 'Pizza', imageUrl: 'assets/images/pizza.png'),
//     Category(name: 'Burger', imageUrl: 'assets/images/burger_image.jpg'),
//     Category(name: 'Salad', imageUrl: 'assets/images/salad.png'),
//     Category(name: 'Spaghetti', imageUrl: 'assets/images/spaghetti_image.jpg'),
//     Category(name: 'Pizza', imageUrl: 'assets/images/pizza.png'),
//     Category(name: 'Burger', imageUrl: 'assets/images/burger_image.jpg'),
//     Category(name: 'Salad', imageUrl: 'assets/images/salad.png'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home page'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.search, color: Colors.grey[700]),
//                   SizedBox(width: 8.0),
//                   Expanded(
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0),
//                       child: TextField(
//                         style: TextStyle(color: Colors.black),
//                         decoration: InputDecoration(
//                           hintText: 'Search...',
//                           hintStyle: TextStyle(color: Colors.grey[700]),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               height: 300,
//               color: Colors.orange[300],
//               padding: EdgeInsets.all(8.0),
//               child: ListView.builder(
//                 itemCount: categories.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   Category category = categories[index];
//                   return CategoryItem(  // Return the CategoryItem widget
//                     nameCategory: category.name,
//                     imageUrlCategory: category.imageUrl,
//                   );
//                 },
//               ),
//             ),
//
//             SizedBox(height: 20),
//             Container(
//               height: 300,
//               color: Colors.orange[300],
//               padding: EdgeInsets.all(8.0),
//               child: ListView.builder(
//                 itemCount: recipes.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   Recipe recipe = recipes[index];
//                   return RecipeItem(
//                     recipe: recipe,
//                     onFavoritePressed: () {
//                       setState(() {
//                         recipe.isFavorite = !recipe.isFavorite;
//                       });
//                     },
//                   );
//
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
