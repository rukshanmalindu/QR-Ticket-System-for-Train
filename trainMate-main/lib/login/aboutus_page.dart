import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String version = 'Loading...';

  @override
  void initState() {
    super.initState();
    // Simulate fetching the application version
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        version = '1.0.0'; // Replace with your actual version
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.teal, // Set the desired background color
      ),

      backgroundColor: Colors.white, // Background color
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Our Railway System',
              style: TextStyle(
                fontSize: 24.0, // Increased font size
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Our railway system has been serving passengers for decades, providing safe and efficient transportation across the country. We are committed to delivering the best travel experience for our passengers.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black, // Text color
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Application Version',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Version: $version',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black, // Text color
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'If you have any questions or feedback, please feel free to contact us at:',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black, // Text color
              ),
            ),
            Text(
              'Email: trainmate@railway.com',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black, // Hyperlink color
                decoration: TextDecoration.underline, // Underline the hyperlink
              ),
            ),
          ],
        ),
      ),
    );
  }
}

