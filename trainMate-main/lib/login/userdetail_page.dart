import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late User loggedInUser;
  late String email;
  String name = '';
  String idNumber = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchUserData();
  }

  // Get the currently logged in user
  void getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      loggedInUser = user;
      email = loggedInUser.email ?? '';
    }
  }

  // Function to fetch user data from Firestore
  Future<void> fetchUserData() async {
    final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      final userData = userSnapshot.docs.first.data() as Map<String, dynamic>;
      setState(() {
        name = userData['name'] ?? '';
        email = userData['email'] ?? '';
        idNumber = userData['idNumber'] ?? '';
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User info'),
        backgroundColor: Colors.teal, // Set the desired background color
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 35),
                height: 270, // Set the desired height for the background image
                width: double.infinity, // Takes the full width of the screen
                child: Stack(
                  children: [
                    Container(
                      height: 130, // Set the height for the background bar
                      width: double.infinity, // Takes the full width
                      decoration: BoxDecoration(
                        color: Colors.teal, // Set the background color to teal
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ), // Add border radius for the top corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.0), // Shadow color
                            offset: Offset(0, 0), // Shadow offset
                            blurRadius: 0, // Shadow blur radius
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ClipRect(
                        child: Container(
                          height: 240, // Adjust the height as needed for the profile picture
                          width: 140, // Adjust the width as needed for the profile picture
                          child: Center(
                            child: CircleAvatar(
                              radius: 50, // Adjust the radius as needed for the profile picture
                              backgroundColor: Colors.white, // Background color of the profile picture
                              backgroundImage: AssetImage('assets/profile2.png'), // Your profile picture image path
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(140, 80, 20, 20),
                      child: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Hi ',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 30, // Change the font size for "Hello"
                                color: Colors.black,
                                backgroundColor: Colors.transparent,
                                letterSpacing: 1.0,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                            TextSpan(
                              text: name, // The name variable
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22, // Keep the font size for the name
                                color: Colors.black,
                                backgroundColor: Colors.transparent,
                                letterSpacing: 0.1,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              _buildDetailRow('Name:', name),
              _buildDetailRow('email:', email),
              _buildDetailRow('ID Number:', idNumber),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build a row with a label and value
  Widget _buildDetailRow(String label, String value) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  decorationColor: Colors.blue,
                  decorationThickness: 2.0,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: 20, // Adjust the width of the third decoration
              height: 20, // Adjust the height of the third decoration

            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          thickness: 1.0,
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  }

