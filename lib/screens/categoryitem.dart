import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String nameCategory;
  final String imageUrlCategory;

  // Constructor to initialize CategoryItem
  CategoryItem({required this.nameCategory, required this.imageUrlCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              imageUrlCategory,
              width: 120, // Set the width as needed
              height: 100, // Set the height as needed
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10), // Add some spacing between image and text
          SizedBox(
            width: 200, // Set a fixed width or adjust as needed
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
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
              child: Text(
                nameCategory,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
