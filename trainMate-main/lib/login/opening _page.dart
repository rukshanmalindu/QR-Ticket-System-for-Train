import 'package:flutter/material.dart';

import 'Login_page.dart';

class OpeningPage extends StatefulWidget {
  @override
  _OpeningPageState createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  @override
  void initState() {
    super.initState();

    // Add a delay before changing the screen
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to the login page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20), // Add spacing

            TweenAnimationBuilder(
              duration: Duration(seconds: 5),
              tween: Tween(begin: 0.5, end: 1.0), // Start small (0.5) and grow to 1.0
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Container(
                width: 200, // Adjust the initial container size
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  shape: BoxShape.circle, // Make it a circle
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icon1.png', // Replace with your logo
                    width: 200, // Adjust the image size
                    height: 200,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Welcome to trainMate',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
                letterSpacing: 2.0, // Adjust letter spacing
                decorationColor: Colors.green, // Underline color
                decorationThickness: 2.0, // Underline thickness
                shadows: [
                  Shadow(
                    color: Colors.grey, // Text shadow color
                    offset: Offset(2, 2), // Shadow offset
                    blurRadius: 3, // Shadow blur radius
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
