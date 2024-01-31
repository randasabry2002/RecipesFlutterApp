import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'category.dart';

class CategoryItem extends StatelessWidget {
  String? nameCategory;
  String? imageUrlCategory;
  // Constructor to initialize CategoryItem
  CategoryItem({super.key, this.nameCategory, this.imageUrlCategory});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            width: 200, // Set a fixed width or adjust as needed
            child: InkWell(
              onTap: () {
          // Use Get.to to navigate to the CategoryPage
          Get.to(() => CategoryPage());
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
