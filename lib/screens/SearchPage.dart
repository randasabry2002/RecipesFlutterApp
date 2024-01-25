
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Search Page",
          style: TextStyle(fontFamily: 'Poppins'), // Title color
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,// Background color of the app bar

      ),
      body:
          Container(
            margin: EdgeInsets.only(top: 40, right: 20, left: 20),
            // padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  color: Color(0xff1D1617).withOpacity(0.11),
                  blurRadius: 40,
                  spreadRadius: 0.0
                )]

              ),
            child: TextField(

              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(15),
              // Search icon
                prefixIcon: Padding(padding: EdgeInsets.all(8.0),child: Icon(Icons.search, color: Colors.grey[700]),),
                hintText: 'Search...',
                 hintStyle: TextStyle(color: Colors.grey[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none
                ),
              ),
            ),
          ),
          // Add your content here

    );
  }
}




