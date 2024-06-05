import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VoiceAgent extends StatelessWidget {
  const VoiceAgent({super.key});
  final String phoneNumber_1 = '+94 11 4 600 111';
  final String phoneNumber_2 = '+94 11 4 600 111';
  final String phoneNumber_3 = '+94 11 2 434215';
  final String phoneNumber_4 = '1971';
  final String phoneNumber_5 = '+94 11 2 692286';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Voice agent"),
          backgroundColor: Colors.teal,
        ),
        body: ListView(
          children: [
            Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 103, 119, 132)
                            .withOpacity(0.5),
                        blurRadius: 5.0,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Column(
                  children: [
                    Container(
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text(
                          'Welcome to our service section',
                          style: TextStyle(
                            fontSize: 18.0, // Adjust the font size
                            color: Colors.black, // Change text color
                            fontWeight: FontWeight.bold, // Adjust font weight
                            fontStyle: FontStyle.normal, // Adjust font style
                            letterSpacing: 1.2, // Adjust letter spacing
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    Container(
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text(
                          'The train ticket reservation app offers a user-friendly platform for travelers to efficiently book train tickets. It provides real-time train information, pricing, and excellent customer support. With a reliable track record and a growing number of bookings, the app ensures a convenient and satisfying travel experience for users.',
                          style: TextStyle(
                            fontSize: 14.0, // Adjust the font size
                            color: Colors.black, // Change text color
                            fontWeight: FontWeight.normal, // Adjust font weight
                            fontStyle: FontStyle.normal, // Adjust font style
                            letterSpacing: 1.2, // Adjust letter spacing
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                )),
//********** */
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 103, 119, 132)
                          .withOpacity(0.5),
                      blurRadius: 5.0,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              padding: const EdgeInsets.all(14.0),
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to the left
                children: [
                  Text(
                    'For Efficient Service Contact Us',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 13.0), // Add some spacing

                  Padding(
                    padding: EdgeInsets.all(10.0), // Add padding
                    child: Column(
                      children: [
                        Text(
                          'Colombo Fort : +94 11 4 600 111',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            _makePhoneCall_1('tel:$phoneNumber_1');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal, // Change the button's background color to orange
                            elevation: 0.0,
                          ),
                          child: Text('Call Us'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 0.0,
                        right: 10.0,
                        left: 10.0), // Add padding
                    child: Column(
                      children: [
                        Text(
                          'Railway Head Office Exchange Number : ',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 0.0,
                        left: 10.0,
                        right: 10.0,
                        bottom: 10.0), // Add padding
                    child: Column(
                      children: [
                        Text(
                          '+94 11 4 600 111',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            _makePhoneCall_2('tel:$phoneNumber_1');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal, // Change the button's background color to orange
                            elevation: 0.0,
                          ),
                          child: Text('Call Us'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 0.0,
                        right: 10.0,
                        left: 10.0), // Add padding
                    child: Column(
                      children: [
                        Text(
                          'Fort Railway Station Inquiries : +94 11 2 434215',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            _makePhoneCall_3('tel:$phoneNumber_1');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal, // Change the button's background color to orange
                            elevation: 0.0,
                          ),
                          child: Text('Call Us'),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 0.0,
                        right: 10.0,
                        left: 10.0), // Add padding
                    child: Column(
                      children: [
                        Text(
                          'Deputy Operating Superintendent  : 1971',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            _makePhoneCall_4('tel:$phoneNumber_1');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal, // Change the button's background color to orange
                            elevation: 0.0,
                          ),
                          child: Text('Call Us'),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.0), // Add padding
                    child: Column(
                      children: [
                        Text(
                          'Assistant Transportation Superintendent (Operation)  : +94 11 2 692286',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            _makePhoneCall_5('tel:$phoneNumber_1');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal, // Change the button's background color to orange
                            elevation: 0.0,
                          ),
                          child: Text('Call Us'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  // Function to make a phone call
  _makePhoneCall_1(String phoneNumber_1) async {
    if (await canLaunch(phoneNumber_1)) {
      await launch(phoneNumber_1);
    } else {
      throw 'Could not launch $phoneNumber_1';
    }
  }

  _makePhoneCall_2(String phoneNumber_2) async {
    if (await canLaunch(phoneNumber_2)) {
      await launch(phoneNumber_2);
    } else {
      throw 'Could not launch $phoneNumber_2';
    }
  }

  _makePhoneCall_3(String phoneNumber_3) async {
    if (await canLaunch(phoneNumber_3)) {
      await launch(phoneNumber_3);
    } else {
      throw 'Could not launch $phoneNumber_3';
    }
  }

  _makePhoneCall_4(String phoneNumber_4) async {
    if (await canLaunch(phoneNumber_4)) {
      await launch(phoneNumber_4);
    } else {
      throw 'Could not launch $phoneNumber_4';
    }
  }

  _makePhoneCall_5(String phoneNumber_5) async {
    if (await canLaunch(phoneNumber_5)) {
      await launch(phoneNumber_5);
    } else {
      throw 'Could not launch $phoneNumber_5';
    }
  }
}