import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled12/login/Login_page.dart';
import 'package:untitled12/login/userdetail_page.dart';
import 'aboutus_page.dart';
import 'editprofile_page.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  String userName = '';
  String userEmail = '';
  String useridNumber = '';
  File? _image;




  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        setState(() {
          userName = userSnapshot.docs.first.get('name') ?? '';
          userEmail = userSnapshot.docs.first.get('email') ?? '';
          useridNumber = userSnapshot.docs.first.get('idNumber') ?? '';
        });
      }
    }
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Background Image or Banner
            Container(
              height: 250, // Set the desired height for the background image
              width: double.infinity, // Takes the full width of the screen
              child: Stack(
                children: [
                  Container(
                    height: 190, // Set the height for the background image
                    width: double.infinity, // Takes the full width
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/profile1.jpeg'), // Set the background image
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ), // Add border radius for the top corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.9), // Shadow color
                          offset: Offset(0, 9), // Shadow offset
                          blurRadius: 9, // Shadow blur radius
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRect(
                      child: Container(
                        height: 170, // Adjust the height as needed for the profile picture
                        width: 110, // Adjust the width as needed for the profile picture
                        child: Center(
                          child: CircleAvatar(
                            radius: 60, // Adjust the radius as needed for the profile picture
                            backgroundColor: Colors.white, // Background color of the profile picture
                            backgroundImage: AssetImage('assets/profile2.png'), // Your profile picture image path
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Text(
              userName,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
                backgroundColor: Colors.white, // Background color
                letterSpacing: 1.0, // Adjust letter spacing
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(0, 0), // Add a shadow with offset
                  ),
                ],
              ),
            ),
            SizedBox(height: 2),
            Text(
              userEmail,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey, // Text color
                fontStyle: FontStyle.italic, // Apply italic style
                decorationColor: Colors.blue, // Decoration color
                decorationStyle: TextDecorationStyle.dashed, // Decoration style
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: ProfileOption(
                icon: Icons.info,
                title: 'User Info',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsPage(),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: ProfileOption(
                icon: Icons.edit,
                title: 'Edit Profile',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: ProfileOption(
                icon: Icons.info,
                title: 'About Us',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUsPage(),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: ProfileOption(
                icon: Icons.logout,
                title: 'Logout',
                onPressed: () async {
                  // Handle logout here
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(), // Replace with your login screen
                      ),
                    );
                  } catch (e) {
                    print("Error logging out: $e");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onPressed;

  ProfileOption({
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white, // Background color for the container
          borderRadius: BorderRadius.circular(12), // Add border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.9), // Shadow color
              offset: Offset(0, 3), // Shadow offset
              blurRadius: 9, // Shadow blur radius
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 24,
              color: Colors.blue,
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black, // Text color
                fontWeight: FontWeight.bold, // Apply bold style
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}



