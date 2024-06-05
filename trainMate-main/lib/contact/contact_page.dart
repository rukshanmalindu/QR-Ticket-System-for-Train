import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, InnerBoxIsScrolled) => [
          const SliverAppBar(
            floating: true,
            snap: true,
            title: Text(
              "Contact Us",
            ),
            backgroundColor: Colors.teal,
          )
        ],
        body: ListView(
          children: [
            Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color:
                        const Color.fromARGB(255, 103, 119, 132).withOpacity(0.5),
                        blurRadius: 5.0,
                        offset: const Offset(0, 3),
                      ),
                    ]),
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
                )),
//****************************** */
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color:
                      const Color.fromARGB(255, 103, 119, 132).withOpacity(0.5),
                      blurRadius: 5.0,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              padding: const EdgeInsets.all(14.0),
              margin: const EdgeInsets.all(10),
              child: const Column(
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
                    child: Text(
                      'Email: slrailway@gmail.com',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.0), // Add padding
                    child: Text(
                      'Phone: (123) 456-7890',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0), // Add padding
                    child: Text(
                      'Social Media:',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 80, right: 20, top: 20, bottom: 20),
                        child: Icon(
                          Icons.facebook,
                          size: 30.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.install_mobile,
                          size: 30.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.twelve_mp,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )

            //*************************** */
          ],
        ),
      ),
    );
  }
}