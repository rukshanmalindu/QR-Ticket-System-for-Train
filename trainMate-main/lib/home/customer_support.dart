import 'package:flutter/material.dart';
import '../contact/chatwith_page.dart';
import '../contact/contact_page.dart';
import '../contact/voicecenter_page.dart';
import 'navigation.dart';

class MyCustomerSupportPage extends StatefulWidget {
  const MyCustomerSupportPage({super.key});

  @override
  State<MyCustomerSupportPage> createState() => _MyCustomerSupportPageState();
}

class _MyCustomerSupportPageState extends State<MyCustomerSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Customer Support'),
    backgroundColor: Colors.teal, // Set the desired background color
    ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            // width: double.infinity,
            // height: double.infinity,
            //color: Colors.black12,

            child: Column(
              //mainAxisAlignment: MainAxisAlignment.values,
              children: [
                Container(
                  width: 350,
                  height: 151,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/contact.jpeg',
                          width: 350.0,
                          height: 150.0,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5), // Semi-transparent black overlay
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 100),
                            child: Text(
                              'Welcome to trainMate Customer Help Center. How can we help?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),

                /******Wel Come Bar******* */
                Container(
                  width: double.infinity,
                  height: 110,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        DecoratedButton(
                          text: "Chat with Dia",
                          icon: Icons.chat,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return const ChatWithDia();
                            }
                            ),
                            );
                          },
                        ),
                        DecoratedButton(
                          text: "Make a Request",
                          icon: Icons.note_alt_sharp,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return const Contact();
                            }
                            )
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                ),

                SizedBox(height: 70),
                /*******Column 01********* */
                Container(
                  width: double.infinity,
                  height: 110,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        DecoratedButton(
                          text: "Voice Agent",
                          icon: Icons.voice_chat,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return const VoiceAgent();
                            }
                            )
                            );
                          },
                        ),
                        DecoratedButton(
                          text: "Contact Us",
                          icon: Icons.contact_page,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return const Contact();
                            }
                            ),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            /******Column 03****** */

            //alignment: Alignment.topLeft,
          ),
        ],
      ),
    );

  }
}

class DecoratedButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  DecoratedButton({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 133,
      height: 125,
      margin: const EdgeInsets.only(left: 10, right: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.blueGrey,
              size: 50,
            ),
            SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

