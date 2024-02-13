import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipes_flutter_app/screens/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/UsersController.dart';
import 'Navigation.dart';
import 'package:get/get.dart';
class Signin extends StatefulWidget {
  @override
  State<Signin> createState() {
    return SigninState();
  }
}

class SigninState extends State<Signin> {
  bool isValidEmail(String email) {
    // Regular expression to check for a valid email format
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  String password = '';
  String email = '';
  bool isPasswordVisible = true;
  final UsersController usersController = Get.put(UsersController());
  final _auth = FirebaseAuth.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(

          padding: const EdgeInsets.fromLTRB(20, 30, 20, 50),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/recipeicon.png',
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 20),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                  // Check if the entered email is in a valid format

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
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
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
                  if (password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Enter your password"),
                      ),
                    );
                  }
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
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (_auth.currentUser != null) {
                        final SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                        await _prefs.setString(
                            "email", _auth.currentUser!.email.toString());

                        await usersController.getUserByEmail(
                            _auth.currentUser!.email.toString());
                        await _prefs.setString(
                            "userName",
                            usersController.userByEmail.value.UserName!);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Navigation(),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Invalid email or password"),
                        ),
                      );
                      print("Wrong Email or Password");
                      // const SnackBar(
                      //   content: Text("Wrong Email or Password"),
                      // );
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Wrong Email or Password"),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await GoogleSignIn().signOut();
                    final GoogleSignInAccount? googleUser =
                    await GoogleSignIn().signIn();

                    final GoogleSignInAuthentication googleAuth =
                    await googleUser!.authentication;

                    final credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );
                    await _auth.signInWithCredential(credential);
                    if (_auth.currentUser != null) {
                      final SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                      await _prefs.setString(
                          "email", _auth.currentUser!.email.toString());

                      await usersController.getUserByEmail(
                          _auth.currentUser!.email.toString());
                      await _prefs.setString(
                          "userName",
                          usersController.userByEmail.value.UserName!);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Navigation(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: const Text(
                    'Sign In With Google',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.grey, fontSize: 20.0),
                  children: <TextSpan>[
                    const TextSpan(text: "If you don't have account "),
                    TextSpan(
                      text: 'Sign up',
                      style: const TextStyle(color: Colors.green),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Sign up');
                          Get.to(() => SignUp());
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
