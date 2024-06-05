import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../home/upgrade_page.dart';

class Payment extends StatefulWidget {
  int noUpgradeTickets;
  String selectedClass;
  String bookingtrainType;
  double Total;
  double payBalance;
  final TextEditingController updateTo;
  final String nationalID;
  double distance;
  Payment({
    required this.noUpgradeTickets,
    required this.selectedClass,
    required this.updateTo,
    required this.bookingtrainType,
    required this.Total,
    required this.distance,
    required this.payBalance, required this.nationalID,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  final String Date = "2023/11/02";
  final String Ticket_amount = '100';
  final String Wallet = '150';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Update Details',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 40),
                Container(
                  child: Row(
                    children: [
                      const Text(
                        'Destination :  ',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        widget.updateTo.text,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Row(
                    children: [
                      const Text(
                        'Distance      :  ',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        widget.distance.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Row(
                    children: [
                      const Text(
                        'Date   :  ',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        Date,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Row(
                    children: [
                      const Text(
                        'No of Tickets updated :  ',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        widget.noUpgradeTickets.toString(),
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Row(
                    children: [
                      const Text(
                        'Class :  ',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        widget.selectedClass,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Row(
                    children: [
                      const Text(
                        'Train Type :  ',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        widget.bookingtrainType,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Row(
                    children: [
                      const Text(
                        'Overall Total :  ',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        widget.Total.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                  'You have to pay:Rs.',
                  style: TextStyle(fontSize: 20.0,),
                ),
                Text(
                  widget.payBalance.toStringAsFixed(1),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 0.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100.0,
          ),
          Container(
            margin: const EdgeInsets.only(left: 100, right: 100.0,bottom: 30.0),
            child: ElevatedButton(
              onPressed: () {


                FirebaseFirestore firestore = FirebaseFirestore.instance;
                CollectionReference collection = firestore.collection(widget.nationalID);


                String customDocumentName = 'Upgrade details';
                // Create a map with data
                Map<String, dynamic> data = {

                  "Updated Destination":widget.updateTo.text,
                  "Overall Total":widget.Total,
                  "Updated Tickets":widget.noUpgradeTickets,
                  "Class": widget.selectedClass,
                  "Train Type":widget.bookingtrainType,
                  "Date":Date,
                  "You have to pay":widget.payBalance,

                };

                collection.doc(customDocumentName).set(data).then((_) {

                  print('Data added to Firestore');
                }).catchError((error) {

                  print('Error adding data to Firestore: $error');
                });





/*
 setState(() {

      //widget.textFrom = '';
      widget.updateTo.text = '';
      widget.Total = 0.0;
      widget.noUpgradeTickets = 0;
      widget.selectedClass = '';
      widget.bookingtrainType = '';
     // widget.Date = DateTime.now();
      widget.payBalance = 0.0;
          });

*/


                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Upgrade(


                  )),
                );






                int intTicketAmount = int.parse(Ticket_amount);
                int intWallet = int.parse(Wallet);
                if (intTicketAmount < intWallet) {
                  // Handle the payment logic here
                } else {
                  // Handle insufficient funds
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Change the button's background color to orange
                elevation: 0.0,
              ),
              child: const SizedBox(
                child: Text(
                  'Pay Now',
                  style: TextStyle(
                    fontSize: 20, // Adjust the font size as needed
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