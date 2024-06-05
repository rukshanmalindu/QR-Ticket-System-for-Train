import 'package:flutter/material.dart';
import 'package:untitled12/home/recharge.dart';
import 'package:untitled12/home/upgrade_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import '../home/booking2_page.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body:NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context,InnerBoxIsScrolled)=>[
          SliverAppBar(
            floating: true,
            snap: true,
            title: Container(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0, // Adjust the border width as needed
                  ),
                  borderRadius: BorderRadius.circular(10.0), // Adjust the border radius for rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
                  child: const Text(
                    "trainMate",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ShadowsIntoLight', // Use a custom font if desired
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent, // Set a transparent background for the SliverAppBar
            actions: [
              Container(
                margin: EdgeInsets.all(38.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(136, 212, 211, 211),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                // You can add any other widgets or content you want here.
              ),
            ],
          )



        ],
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30))),
              child: Column(
                children: [
                  // Add play*****************
                  Container(
                    height: 250,
                    width:double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    child: ScrollLoopAutoScroll(
                      scrollDirection: Axis.horizontal,
                      delay: const Duration(seconds: 1),
                      duration: const Duration(seconds: 500),
                      gap: 25,
                      reverseScroll: false,
                      duplicateChild : 25,
                      enableScrollInput : true,
                      delayAfterScrollInput : const Duration(seconds: 1),
/***************************/
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 330.0,
                            height: 200.0,
                            margin: const EdgeInsets.only(top: 5, left: 25, right: 15.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 120, 525, 577).withOpacity(0.5),
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/booking.png',
                                    width: 330.0,
                                    height: 200.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                /*const Center(
                                  child: Text(
                                    'Enjoy with \ntrainMate',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 20, 1, 74),
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          Container(
                            width: 330.0,
                            height: 200.0,
                            margin: const EdgeInsets.only(top: 5, left: 25, right: 15.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 6, 71, 43).withOpacity(0.5),
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/upgrde.png',
                                    width: 330.0,
                                    height: 200.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                /*const Center(
                                  child: Text(
                                    'Grab Your\nQR E Ticket',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 211, 236, 24),
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          Container(
                            width: 330.0,
                            height: 200.0,
                            margin: const EdgeInsets.only(top: 5, left: 25, right: 15.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 420, 525, 177).withOpacity(0.5),
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/qr.jpeg',
                                    width: 330.0,
                                    height: 200.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                /*const Center(
                                  child: Text(
                                    'Now you can \nupgrade Tickets \nduring your journey',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 100, 168, 106),
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                      /************************ */
                    ),
                  ),
                  /*********************************** */
                  // TrainSchedule **************
                  Container(
                    height: 220,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 71, 71, 72).withOpacity(0.1),
                          blurRadius: 15.0,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.teal, // Background color
                            borderRadius: BorderRadius.circular(12.0), // Border radius to create a curved shape
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _launchURL(); // Call the onPressed function when the button is tapped
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 77.0, vertical: 15.0),
                                child: Text(
                                  "Train Schedule",
                                  style: TextStyle(
                                    fontSize: 18.0, // Text size
                                    color: Colors.white, // Text color
                                    fontWeight: FontWeight.bold, // Text weight
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SEARCH(initialText1: '', initialText2: '')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal, // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0), // Border radius for a curved shape
                            ),
                            elevation: 5, // Shadow elevation
                            padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 15.0), // Padding around the text
                          ),
                          child: Text(
                            "Booking & Purchase",
                            style: TextStyle(
                              fontSize: 18.0, // Text size
                              color: Colors.white, // Text color
                              fontWeight: FontWeight.bold, // Text weight
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Upgrade()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal, // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0), // Border radius for a curved shape
                            ),
                            elevation: 5, // Shadow elevation
                            padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0), // Padding around the text
                          ),
                          child: Text(
                            "Upgrade Tickets",
                            style: TextStyle(
                              fontSize: 18.0, // Text size
                              color: Colors.white, // Text color
                              fontWeight: FontWeight.bold, // Text weight
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //Balance
//*****************************
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                    decoration:  BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 71, 71, 72).withOpacity(0.8),
                          blurRadius: 5.0,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Wallet Balance",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                          ),
                        ),
                        const Text(
                          "Rs.250.00",
                          style: TextStyle(
                            color: Color.fromRGBO(158, 16, 6, 0.847),
                            fontSize: 33,
                            //  fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RechargeAccountPage()),);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal, // Background color
                            onPrimary: Colors.white, // Text color
                            padding: EdgeInsets.symmetric(horizontal: 23.0, vertical: 10.0), // Padding around the button content
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0), // Border radius for a curved shape
                            ),
                            elevation: 5, // Shadow elevation
                          ),
                          child: const Text(
                            "Recharge",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
//*******************************
                  // Images
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 98, 98, 99).withOpacity(1.0),
                              blurRadius: 45.0,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/train.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //******************** */
                      Positioned(
                        bottom: 20,
                        left: 15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sri Lanka Railway',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                // Add your web link navigation logic here
                                // For example, you can use the launch() function to open a URL.
                                // import 'package:url_launcher/url_launcher.dart';
                                // launch('https://example.com');
                              },
                              child: const Text(
                                'https://srilankarailway.com',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //********************** */
                    ],
                  ),
                ],
              ),
            ),

            //End of 4 box
          ],
        ),
      ),
    );
  }


  _launchURL() async {
    const url = 'https://slr.malindaprasad.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildHoverButton({
    required String text,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    bool isHovered = false;
    return MouseRegion(
      onEnter: (_) {
        // Mouse pointer enters the button
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        // Mouse pointer exits the button
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Duration of the hover animation
        margin: const EdgeInsets.only(top: 16,),
        width: 290,
        height: 60,
        decoration: BoxDecoration(
          color: isHovered ? Colors.blue : const Color.fromARGB(255, 47, 89, 227),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Transparent background
            elevation: 0, // No shadow
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isHovered ? Colors.white : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}