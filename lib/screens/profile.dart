import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recipes_flutter_app/screens/Signin.dart';
import '../controllers/UsersController.dart';
import 'Navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UsersController usersController = Get.put(UsersController());
  final _auth = FirebaseAuth.instance;
  File? _image;

  getImage() async {
    await usersController.getUserByEmail(_auth.currentUser!.email!);
    _image = await File(usersController.userByEmail.value.ProfileImagePath!);
    setState(() {

    });
  }

  Future<void> chooseImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    getImage();

    return Scaffold(
      backgroundColor: Colors.grey[200], // Use a light grey background
      appBar: AppBar(
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 0, // No elevation for a clean look
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,// Center the contents vertically
            children: [
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipOval(
                    child: _image != null
                        ? Image.file(
                      _image!,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      "assets/images/profile.jpg",
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,),
                  ),
                  Positioned(
                    right: 5, // Adjust the position of the icon as needed
                    bottom: 5, // Adjust the position of the icon as needed
                    child: IconButton(
                      onPressed: () {
                        chooseImage();
                      },
                      icon: Icon(Icons.edit,size: 35,),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40,20,0,20),
                    child: Text(
                      'UserName:',
                      style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,20,40,20),
                    child: Text(
                      '${usersController.userByEmail.value.UserName}',
                      style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40,20,0,20),
                    child: Text(
                      'Email:',
                      style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,20,40,20),
                    child: Text(
                      '${usersController.userByEmail.value.Email}',
                      style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Row(
              //   children: [
              //     const Padding(
              //       padding: EdgeInsets.fromLTRB(40,20,0,20),
              //       child: Text(
              //         'Password:',
              //         style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.fromLTRB(0,20,40,20),
              //       child: Text(
              //         '${usersController.userByEmail.value.Password}',
              //         style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ],
              // ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  // Navigate to the Home screen when the button is pressed
                  final SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  await _prefs.setString(
                      "email", "null");
                  await _prefs.setString(
                      "userName", "null");
                  Get.to(() => Signin());
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Use a red color for the button
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
