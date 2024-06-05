import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled12/home/navigation.dart';
import 'package:untitled12/login/home_page.dart';
import '../home/booking2_page.dart';
import 'package:intl/intl.dart';

class PaymentBooking extends StatefulWidget {


  String textFrom;
  String To;
  double Distance;
  String No_Of_Passenger;
  String trainclass;
  String Train_Type;
  DateTime Date;
  double Total_Bookin_Price;
  double bookdistance;
  //final String qrID;


  PaymentBooking({
    required this.textFrom,
    required this.To,
    required this.Distance,
    required this.No_Of_Passenger,
    required this.trainclass,
    required this.Train_Type,
    required this.Date,
    required this.Total_Bookin_Price,
    required this.bookdistance,

    //required this.qrID,
  });


  @override
  State<PaymentBooking> createState() => _PaymentBookingState();
}

class _PaymentBookingState extends State<PaymentBooking> {



  //String userName = '';
  //String userEmail = '';
  String useridNumber = '';


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
          //userName = userSnapshot.docs.first.get('name') ?? '';
          //userEmail = userSnapshot.docs.first.get('email') ?? '';
          useridNumber = userSnapshot.docs.first.get('idNumber') ?? '';
        });
      }
    }
  }














  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.teal, // Set the background color to teal
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20.0, top: 40.0, right: 20.0),
            padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 25.0, bottom: 35.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 103, 119, 132).withOpacity(0.5),
                  blurRadius: 5.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Card(
              margin: EdgeInsets.all(16.0),
              elevation: 5.0, // Add elevation for a shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Add rounded corners
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Booking Tickets Details',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'From:  ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          widget.textFrom,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'To:      ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          widget.To,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Distance: ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          widget.bookdistance.toStringAsFixed(2),
                          style: TextStyle(fontSize: 20.0),
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Date: ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd / HH:mm').format(widget.Date),
                          style: TextStyle(fontSize: 20.0),
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'No of Passenger:  ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          widget.No_Of_Passenger.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Class:  ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          widget.trainclass,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Train Type:  ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          widget.Train_Type,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )

          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
            padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 25.0, bottom: 25.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 103, 119, 132).withOpacity(0.5),
                  blurRadius: 5.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Text(
                  'Total : Rs. ',
                  style: TextStyle(fontSize: 20.0,),
                ),
                Text(
                  widget.Total_Bookin_Price.toStringAsFixed(2),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 0.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            margin: const EdgeInsets.only(left: 100, right: 100.0,bottom: 60.0),
            child: ElevatedButton(
              onPressed: () {
                FirebaseFirestore firestore = FirebaseFirestore.instance;
                CollectionReference collection = firestore.collection('${useridNumber}');
                String customDocumentName = 'Booking details';
                // Create a map with data
                Map<String, dynamic> data = {
                  "From":widget.textFrom,
                  "To":widget.To,
                  "Distance":widget.bookdistance,
                  "Overall Total":widget.Total_Bookin_Price,
                  "No Of Passenger":widget.No_Of_Passenger,
                  "Class": widget.trainclass,
                  "Train Type":widget.Train_Type,
                  "Date":widget.Date,
                };
                collection.doc(customDocumentName).set(data).then((_) {
                  print('Data added to Firestore');
                }).catchError((error) {
                  print('Error adding data to Firestore: $error');
                });
                /*
 Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Qr(
              textFrom: widget.textFrom,
              To:widget.To,
              Distance:widget.Distance,
              No_Of_Passenger:widget.No_Of_Passenger,
              trainclass:widget.trainclass, //class
              Train_Type:widget.Train_Type,
              Date:widget.Date,
               Total_Bookin_Price:widget.Total_Bookin_Price,
              bookdistance:widget.bookdistance,
)),
          );
setState(() {

      widget.textFrom = '';
      widget.To = '';
      widget.Distance = 0.0;
      widget.No_Of_Passenger = '';
      widget.trainclass = '';
      widget.Train_Type = '';
      widget.Date = DateTime.now();
      widget.Total_Bookin_Price = 0.0;
          });

   */

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Navigation()),
                );





                // int intTicketAmount = int.parse(Ticket_amount);
                // int intWallet = int.parse(Wallet);
                // if (intTicketAmount < intWallet) {
                // Handle the payment logic here
                // } else {
                // Handle insufficient funds
                // }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.teal), // Set the background color
              ),
              child: const SizedBox(
                child: Text(
                'Pay Now',
                style: TextStyle(
                  fontSize: 20, // Adjust the font size as needed
                  color: Colors.white, // Set the desired text color
                ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}