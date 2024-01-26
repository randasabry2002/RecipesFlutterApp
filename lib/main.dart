import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipes_flutter_app/screens/firstpage.dart';
import 'package:recipes_flutter_app/screens/AddRecpies.dart';
import 'package:recipes_flutter_app/screens/SplashScreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions( apiKey: "AIzaSyAUDvl3fodKFTPdAJFca8V60UCgZuD4teo",
          authDomain: "recipesflutterapp-fbc53.firebaseapp.com",
          projectId: "recipesflutterapp-fbc53",
          storageBucket: "recipesflutterapp-fbc53.appspot.com",
          messagingSenderId: "128127910877",
          appId: "1:128127910877:web:05f8293bd0c4e25c552c34",
          measurementId: "G-MB78XHYGVW")

  );

  // runApp(MaterialApp(home: firstpage(),debugShowCheckedModeBanner: false,));
  runApp(MaterialApp(home: SplashView(),
    debugShowCheckedModeBanner: false,
    color: Colors.white,
  ));
}
