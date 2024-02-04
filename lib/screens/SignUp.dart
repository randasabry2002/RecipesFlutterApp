import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'Navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {

  @override
  State<SignUp> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp>{
  String password = '';
  String email = '';
  String userName = '';
  bool isPasswordVisible = true;
  File? _image;

  final _auth = FirebaseAuth.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var _firestor = FirebaseFirestore.instance;


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

  addUser(){
    _firestor.collection("Users").add({
      "UserName": userName,
      "Email": _auth.currentUser!.email,
      "Password": password,
      "ProfileImagePath": _image!.path,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 150, 20, 50),
          child: Column(
            children: [
              const SizedBox(height: 20),
              ClipOval(
                child: _image != null
                    ? Image.file(
                  _image!,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  "assets/images/profile.jpg",
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,),
              ),

              const SizedBox(height: 20),

              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.grey, fontSize: 20.0),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Click here to choose Profile Photo',
                        style: const TextStyle(color: Colors.green),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            chooseImage();
                          }),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    userName = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter User Name',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                obscureText: isPasswordVisible,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Enter your password',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                obscureText: isPasswordVisible,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Confirm your password',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await _auth.createUserWithEmailAndPassword(email: email, password: password);

                      if (_auth.currentUser != null) {
                        final SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                        await _prefs.setString("email", _auth.currentUser!.email.toString());
                        await _prefs.setString("userName", userName);

                        addUser();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Navigation(),
                          ),
                        );
                      }
                    } catch (e) {
                      print("Check Your Data, This Email may be used before");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }



}