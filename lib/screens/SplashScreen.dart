import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_flutter_app/screens/Navigation.dart';
import 'package:recipes_flutter_app/screens/Signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homePage.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();

}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Define animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Adjust the duration as needed
    );


    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => Signin()),
    //   );
    // });

    SharedPreferences.getInstance().then((value) {
      String email = value.getString("email").toString();
      print("email: $email");

      // Simulate a delay for demonstration purposes
      Future.delayed(Duration(seconds: 2), () {
        if (email != 'null') {
          // User is logged in, navigate to home or any other screen
          // Replace `HomeScreen` with the actual screen you want to navigate to
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Navigation()),
          );
        } else {
          // User is not logged in, navigate to Signin screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Signin()),
          );
        }
      });
    });

    // Define animation
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Opacity(
                  opacity: 0.9,
                  child: Image.asset(
                    'assets/images/splashIcon .png',
                    fit: BoxFit.fill,
                  ),
                ),

              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: Image.asset('assets/images/recipeicon.png'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}