
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Page",
          style: TextStyle(color: Colors.black), // Title color
        ),
        backgroundColor: Colors.white, // Background color of the app bar


      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Background color of the container
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[700]), // Search icon
                  SizedBox(width: 8.0), // Add some space between icon and text field
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Add your content here
            Container(
                color: Colors.white,
                //child: // Your content goes here,
            ),
          ],
        ),
      ),
    );
  }
}




