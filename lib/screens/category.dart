import 'package:flutter/material.dart';
import 'categoryItem.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<CategoryPage> {
  List<CategoryItem> categories = [
    CategoryItem(nameCategory: 'Spaghetti', imageUrlCategory: 'assets/images/spaghetti_image.jpg'),
    CategoryItem(nameCategory: 'Pizza', imageUrlCategory: 'assets/images/pizza.png'),
    CategoryItem(nameCategory: 'Burger', imageUrlCategory: 'assets/images/burger_image.jpg'),
    CategoryItem(nameCategory: 'Salad', imageUrlCategory: 'assets/images/salad.png'),
    CategoryItem(nameCategory: 'Spaghetti', imageUrlCategory: 'assets/images/spaghetti_image.jpg'),
    CategoryItem(nameCategory: 'Pizza', imageUrlCategory: 'assets/images/pizza.png'),
    CategoryItem(nameCategory: 'Burger', imageUrlCategory: 'assets/images/burger_image.jpg'),
    CategoryItem(nameCategory: 'Salad', imageUrlCategory: 'assets/images/salad.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Page'),
      ),
      body: Container(
        // Remove the height property to let the ListView take up the full height
        color: Colors.grey[300],
        child: ListView.builder(
          itemCount: categories.length,
          // Set the scroll direction to vertical
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            CategoryItem category = categories[index];
            return CategoryItem(
              nameCategory: category.nameCategory,
              imageUrlCategory: category.imageUrlCategory,
            );
          },
        ),
      ),
    );
  }
}
