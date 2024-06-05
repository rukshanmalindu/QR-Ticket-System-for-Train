import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Qr extends StatefulWidget {
  const Qr({Key? key});

  @override
  State<Qr> createState() => _QrState();
}

class _QrState extends State<Qr> {
  String useridNumber = '';

  late String Start_Station = '';
  late String Destination_Station = '';
  late String Train_Type = '';
  late String Class_Type = '';
  late int No_Of_Passenger = 0;
  late double Distance = 0.0;
  late double Total = 0.0;
  late String Date = '';

  String UpgradeClass_Type = '';
  String UpgradeDate = '';
  double UpgradeTotal = 0.0;
  String UpgradeTrain_Type = '';
  String UpgradeDestination_Station = '';
  int UpgradeNo_Of_Passenger = 0;

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
          useridNumber = userSnapshot.docs.first.get('idNumber') ?? '';
          getDataFromFirestoreBooking();
          getDataFromFirestoreUpgrade();
        });
      }
    }
  }

  Future<void> getDataFromFirestoreBooking() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection(useridNumber).doc('Booking details');
    print('hello1');
    try {
      DocumentSnapshot documentSnapshot = await documentReference.get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        print('hello2');
        setState(() {
          Start_Station = data['From'] ?? '';
          Class_Type = data['Class'] ?? '';
          Date = data['date'] ?? '';
          Distance = (data['Distance'] is double) ? data['Distance'] : 0.0;
          No_Of_Passenger = (data['No Of Passenger'] is int) ? data['No Of Passenger'] : 0;
          Total = (data['Overall Total'] is double) ? data['Overall Total'] : 0.0;
          Destination_Station = data['To'] ?? '';
          Train_Type = data['Train Type'] ?? '';
        });
      } else {
        // Document does not exist
      }
    } catch (e) {
      print('Error getting data: $e');
    }
  }

  Future<void> getDataFromFirestoreUpgrade() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference = firestore.collection(useridNumber).doc('Upgrade details');
    print('hello1');
    try {
      DocumentSnapshot documentSnapshot = await documentReference.get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        print('hello2');
        setState(() {
          UpgradeClass_Type = data['Class'] ?? '';
          UpgradeDate = data['date'] ?? '';
          UpgradeTotal = (data['Overall Total'] is double) ? data['Overall Total'] : 0.0;
          UpgradeTrain_Type = data['Train Type'] ?? '';
          UpgradeDestination_Station = data['Updated Destination'] ?? '';
          UpgradeNo_Of_Passenger = (data['Updated Tickets'] is int) ? data['Updated Tickets'] : 0;
        });
      } else {
        // Document does not exist
      }
    } catch (e) {
      print('Error getting data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String combinedValues =
        '$Start_Station $Destination_Station $Distance $Train_Type $Class_Type $No_Of_Passenger $Total $Date $UpgradeClass_Type $UpgradeDate $UpgradeTotal $UpgradeTrain_Type $UpgradeDestination_Station $UpgradeNo_Of_Passenger ';
    print('hello3');
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code'),
        backgroundColor: Colors.teal, // Set the desired background color
      ),
      body: No_Of_Passenger != null
          ? ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 100.0,
              bottom: 15.0,
              left: 25.0,
              right: 25.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                QrImageView(
                  data: combinedValues,
                  version: QrVersions.auto,
                  size: 400.0,
                ),
              ],
            ),
          ),
        ],
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}