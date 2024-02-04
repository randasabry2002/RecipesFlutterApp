import 'dart:io';

import 'package:flutter/material.dart';
import 'Navigation.dart';
import 'package:image_picker/image_picker.dart';

import 'homePage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String password = '';
  String email = 'user@example.com'; // Replace with the actual email
  String gender = 'Male'; // Replace with the actual gender
  String address = '123 Main St, City'; // Replace with the actual address
  bool isPasswordVisible = true;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Use a light grey background
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.cyan,
        elevation: 0, // No elevation for a clean look
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the contents vertically
            children: [
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.black54, // Circle background color
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/religious-meal.png'),
                    ),
                  ),
                  Positioned(
                    right: 2, // Adjust the position of the icon as needed
                    bottom: 2, // Adjust the position of the icon as needed
                    child: IconButton(
                      onPressed: () {
                        // Handle the edit action
                      },
                      icon: Icon(Icons.edit,),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Text(
                'Email: $email',
                style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
              ),

              Text(
                'Gender: $gender',
                style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              Text(
                'Address: $address',
                style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              Text(
                'Password: $password',
                style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the Home screen when the button is pressed
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black12, // Use a red color for the button
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
