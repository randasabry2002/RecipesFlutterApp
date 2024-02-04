//
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'ChatScreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// class Signin extends StatefulWidget {
//   @override
//   _SigninState createState() => _SigninState();
// }
//
// class _SigninState extends State<Signin> {
//   String password = '';
//   String email = '';
//   bool isPasswordVisible = true;
//
//   var _auth = FirebaseAuth.instance;
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.cyan,
//       appBar: AppBar(
//         title: Text('Sign in with Firebase'),
//       ),
//     body: SingleChildScrollView( // Wrap with SingleChildScrollView
//     child: Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Column(
//           children: [
//             SizedBox(height: 20),
//             TextField(
//               textAlign: TextAlign.center,
//               onChanged: (value) {
//                 setState(() {
//                   email = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Enter your email',
//                 contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//                 enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               obscureText: isPasswordVisible,
//               textAlign: TextAlign.center,
//               onChanged: (value) {
//                 setState(() {
//                   password = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 suffixIcon: IconButton(
//                   icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
//                   onPressed: () {
//                     setState(() {
//                       isPasswordVisible = !isPasswordVisible;
//                     });
//                   },
//                 ),
//                 hintText: 'Enter your password',
//                 contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//                 enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   await _auth.createUserWithEmailAndPassword(email: email, password: password);
//                   // You can add a check here to see if the user is already signed in
//                   // and then navigate to ChatScreen.
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ChatScreen(),
//                     ),
//                   );
//                 } catch (e) {
//                   print("Error creating user: $e");
//                   // Handle the error (e.g., show an error message to the user)
//                 }
//               },
//               child: Text('Sign up'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   await _auth.signInWithEmailAndPassword(email: email, password: password);
//                   // Same as above, check the user's sign-in status and navigate accordingly.
//                   if
//                   (_auth.currentUser!=null){
//                     final SharedPreferences _prefs = await SharedPreferences.getInstance();
//                     await _prefs.setString("email", _auth.currentUser!.email.toString());
//                   }
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ChatScreen(),
//                     ),
//                   );
//                 } catch (e) {
//                   print("Error signing in: $e");
//                   // Handle the error (e.g., show an error message to the user)
//                 }
//               },
//               child: Text('Sign in'),
//             ),
//             SizedBox(height: 20),
//            ElevatedButton(onPressed:()async{
//                // Trigger the authentication flow
//   await GoogleSignIn().signOut();
//                final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();//pop up
//
//                // Obtain the auth details from the request
//                final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
//
//                // Create a new credential
//                final credential = GoogleAuthProvider.credential(
//                  accessToken: googleAuth?.accessToken,
//                  idToken: googleAuth?.idToken,
//                );
//                print('checklogin'+googleUser.email);
//                //print('checklogin'+googleUser.);
//
//                await _auth.signInWithCredential(credential);
//   Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//       builder: (context) => ChatScreen(),
//              ));
//                // Once signed in, return the UserCredential
//
//            }, child: Text("Sign In With Google"))
//           ],
//         ),
//       ),
//     ));
//   }
// }
//

















//
//
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'ChatScreen.dart';
//
// class Signin extends StatefulWidget {
//   @override
//   _SigninState createState() => _SigninState();
// }
//
// class _SigninState extends State<Signin> {
//   String password = '';
//   String email = '';
//   bool isPasswordVisible = true;
//   File? _image;
//
//   // late File _image = File(''); //  Initialize the _image variable
//
//   var _auth = FirebaseAuth.instance;
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//
//   Future<void> chooseImage() async {
//     try {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//       if (pickedFile != null) {
//         setState(() {
//           _image = File(pickedFile.path);
//         });
//       } else {
//         print('No image selected.');
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Sign in with Firebase'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               // Add a button to choose an image
//               ElevatedButton(
//                 onPressed: () {
//                   chooseImage();
//                 },
//                 child: Text('Choose Profile Photo'),
//               ),
//               // Display the chosen image
//               _image != null
//                   ? Image.file(
//                 _image!,
//                 height: 100,
//                 width: 100,
//               )
//                   : Container(),
//               SizedBox(height: 20),
//               TextField(
//                 textAlign: TextAlign.center,
//                 onChanged: (value) {
//                   setState(() {
//                     email = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Enter your email',
//                   contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 obscureText: isPasswordVisible,
//                 textAlign: TextAlign.center,
//                 onChanged: (value) {
//                   setState(() {
//                     password = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   suffixIcon: IconButton(
//                     icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
//                     onPressed: () {
//                       setState(() {
//                         isPasswordVisible = !isPasswordVisible;
//                       });
//                     },
//                   ),
//                   hintText: 'Enter your password',
//                   contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     await _auth.createUserWithEmailAndPassword(email: email, password: password);
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ChatScreen(),
//                       ),
//                     );
//                   } catch (e) {
//                     print("Error creating user: $e");
//                   }
//                 },
//                 child: Text('Sign up'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     await _auth.signInWithEmailAndPassword(email: email, password: password);
//                     if (_auth.currentUser != null) {
//                       final SharedPreferences _prefs = await SharedPreferences.getInstance();
//                       await _prefs.setString("email", _auth.currentUser!.email.toString());
//                     }
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ChatScreen(),
//                       ),
//                     );
//                   } catch (e) {
//                     print("Error signing in: $e");
//                   }
//                 },
//                 child: Text('Sign in'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   await GoogleSignIn().signOut();
//                   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//                   final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
//
//                   final credential = GoogleAuthProvider.credential(
//                     accessToken: googleAuth?.accessToken,
//                     idToken: googleAuth?.idToken,
//                   );
//                   await _auth.signInWithCredential(credential);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ChatScreen(),
//                     ),
//                   );
//                 },
//                 child: Text("Sign In With Google"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'ChatScreen.dart';
import 'Navigation.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String password = '';
  String email = '';
  bool isPasswordVisible = true;
  File? _image;

  var _auth = FirebaseAuth.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Sign in with Firebase',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),

              SizedBox(height: 20),
              _image != null
                  ? ClipOval(
                child: Image.file(
                  _image!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              )
                  : Container(),
              ElevatedButton(
                onPressed: () {
                  chooseImage();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan,
                ),
                child: Text(
                  'Choose Profile Photo',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
                ),
              ),
              SizedBox(height: 20),
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
                    icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Enter your password',
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Navigation(),
                      ),
                    );
                  } catch (e) {
                    print("Error creating user: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if (_auth.currentUser != null) {
                      final SharedPreferences _prefs = await SharedPreferences.getInstance();
                      await _prefs.setString("email", _auth.currentUser!.email.toString());
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Navigation(),
                      ),
                    );
                  } catch (e) {
                    print("Error signing in: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await GoogleSignIn().signOut();
                  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                  final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;

                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth?.accessToken,
                    idToken: googleAuth?.idToken,
                  );
                  await _auth.signInWithCredential(credential);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Navigation(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text(
                  'Sign In With Google',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class Signin extends StatefulWidget {
//   @override
//   _SigninState createState() => _SigninState();
// }
//
// class _SigninState extends State<Signin> {
//   String password = '';
//   String email = '';
//   bool isPasswordVisible = true;
//   File? _image;
//
//   var _auth = FirebaseAuth.instance;
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//
//   Future<void> chooseImage() async {
//     try {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//       if (pickedFile != null) {
//         setState(() {
//           _image = File(pickedFile.path);
//         });
//       } else {
//         print('No image selected.');
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'Sign in with Firebase',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.cyan,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   chooseImage();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.cyan,
//                 ),
//                 child: Text(
//                   'Choose Profile Photo',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               _image != null
//                   ? Image.file(
//                 _image!,
//                 height: 100,
//                 width: 100,
//               )
//                   : Container(),
//               SizedBox(height: 20),
//               TextField(
//                 textAlign: TextAlign.center,
//                 onChanged: (value) {
//                   setState(() {
//                     email = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Enter your email',
//                   contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 obscureText: isPasswordVisible,
//                 textAlign: TextAlign.center,
//                 onChanged: (value) {
//                   setState(() {
//                     password = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   suffixIcon: IconButton(
//                     icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
//                     onPressed: () {
//                       setState(() {
//                         isPasswordVisible = !isPasswordVisible;
//                       });
//                     },
//                   ),
//                   hintText: 'Enter your password',
//                   contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     await _auth.createUserWithEmailAndPassword(email: email, password: password);
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ChatScreen(),
//                       ),
//                     );
//                   } catch (e) {
//                     print("Error creating user: $e");
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.green,
//                 ),
//                 child: Text(
//                   'Sign up',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     await _auth.signInWithEmailAndPassword(email: email, password: password);
//                     if (_auth.currentUser != null) {
//                       final SharedPreferences _prefs = await SharedPreferences.getInstance();
//                       await _prefs.setString("email", _auth.currentUser!.email.toString());
//                     }
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ChatScreen(),
//                       ),
//                     );
//                   } catch (e) {
//                     print("Error signing in: $e");
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blue,
//                 ),
//                 child: Text(
//                   'Sign in',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   await GoogleSignIn().signOut();
//                   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//                   final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
//
//                   final credential = GoogleAuthProvider.credential(
//                     accessToken: googleAuth?.accessToken,
//                     idToken: googleAuth?.idToken,
//                   );
//                   await _auth.signInWithCredential(credential);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ChatScreen(),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.red,
//                 ),
//                 child: Text(
//                   'Sign In With Google',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


