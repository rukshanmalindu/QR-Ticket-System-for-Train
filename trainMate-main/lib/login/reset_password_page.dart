import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/trainMate.png', // Replace with the correct image path
                height: 300,
                width: 300,// Adjust the image size as needed
              ),
              SizedBox(height: 20),
              Text(
                'Reset Your Password',
                style: TextStyle(
                  fontSize: 24, // Increase the font size for emphasis
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0), // Adjust the padding as needed
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded border
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final String email = _emailController.text.trim();

                  if (email.isNotEmpty) {
                    // Send a password reset email to the user's email address.
                    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password reset email sent to $email'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter your email.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40), // Increase button width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Add border radius
                    side: BorderSide(color: Color(0xFF14B0D9)), // Add border
                  ),
                  elevation: 15, // Add elevation (shadow)
                ),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigate back to the previous page when the button is pressed.
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: Colors.teal, // Set the text button color
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back),
                    Text('Back to Login'),
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
