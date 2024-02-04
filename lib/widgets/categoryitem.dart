import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/category.dart';

class CategoryItem extends StatelessWidget {
  String? nameCategory;
  String? imageUrlCategory;

  CategoryItem({Key? key, this.nameCategory, this.imageUrlCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7.0),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: InkWell(
              onTap: () {
                if (nameCategory != null) {
                  // Use Get.to to navigate to the CategoryPageeeee and pass the category name
                  Get.to(() => CategoryPageeeee(categoryName: nameCategory!));
                }
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.orange, Colors.transparent],
                  ),
                ),
                child: Center(
                  child: Text(
                    nameCategory!,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
