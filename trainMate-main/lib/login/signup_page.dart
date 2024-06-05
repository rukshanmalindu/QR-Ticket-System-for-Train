import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled12/login/login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _idNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String? _idNumberError;

  // Firestore Security Rules
  // Update your Firestore security rules to allow write access to the "users" collection for authenticated users.
  // Example:
  // service cloud.firestore {
  //   match /databases/{database}/documents {
  //     match /users/{userId} {
  //       allow create: if request.auth != null;
  //     }
  //   }
  // }

  Future<bool> isEmailAlreadyExists(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> isIdNumberAlreadyExists(String idNumber) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('idNumber', isEqualTo: idNumber)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  createUserWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });

      bool emailExists = await isEmailAlreadyExists(_email.text);
      bool idNumberExists = await isIdNumberAlreadyExists(_idNumber.text);

      if (emailExists || idNumberExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email, phone number, or ID number is already in use.'),
          ),
        );

        setState(() {
          isLoading = false;
        });

        return;
      }

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      await FirebaseFirestore.instance.collection('users').doc(credential.user?.uid).set({
        'name': _name.text,
        'idNumber': _idNumber.text,
        'email': _email.text,
        'password': _password.text,
      });

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred while signing up.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: 340.0,
                            height: 200.0,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.teal.withOpacity(0.9), // Shadow color (green)
                                  spreadRadius: 3,
                                  blurRadius: 9,
                                  offset: const Offset(0, 50),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/fnl.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 0.0),
                          Container(
                            child: Text(
                              'Welcome back',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 37,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.teal,
                                    offset: Offset(7, 0),
                                    blurRadius: 9,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40.0),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: _name,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Name is empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  hintText: "Enter your name",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.teal, // Change the icon color to red
                                  ),
                                )
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: _idNumber,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'ID Number is empty';
                                  }
                                  if (text.length < 9 || text.length > 11) {
                                    return 'ID Number should be between 9 and 11 digits';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "ID Number",
                                  hintText: "Enter your ID Number",
                                  errorText: _idNumberError,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10.0),
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(
                                    Icons.perm_identity_rounded,
                                    color: Colors.teal, // Change the icon color to red
                                  ),
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    _idNumberError = null;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: _email,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Email is empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter your Email",
                                  labelText: "Email",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10.0),
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.teal, // Change the icon color to red
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: _password,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Password is empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter your Password",
                                  labelText: "Password",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10.0),
                                  labelStyle: TextStyle(color: Colors.black),
                                  hintStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.teal, // Change the icon color to blue
                                  ),
                                )
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width: 280,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  createUserWithEmailAndPassword();
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.teal),
                                padding: MaterialStateProperty.all(EdgeInsets.all(5.0)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                              child: isLoading
                                  ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                            },
                            child: Text(
                              'Already have an account? Login',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
