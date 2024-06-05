import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../booking/fromscreen_page.dart';
import '../booking/payment.dart';



class Upgrade extends StatefulWidget {
  const Upgrade({super.key});

  @override
  State<Upgrade> createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> {


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






  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late double destiLatitude;
  late double destintLongitude;

  late double total1; //upgrade price1 price1*passenger
  late double price1; //
  late double total2; //the price that should reduce
  late double price2;
  late double Total;
  late double payBalance;

  Location? selectedDestinationLocation;
  Location? selectedbookingdestination;

  int boughtTickets=0;

  int noBokingTickets=0;
  double bookingTotal=0.0;
  String bookingdestination='';
  String bookingtrainType='';
  String bookingClass='';
  String bookingstart='';
  double bokindDistanceistance=0.0;
  String Date='';
  double bookingdestiLatitude=0.0;
  double bookingdestintLongitude=0.0;

  String nationalID ='';
  String qrID = '';
  int noUpgradeTickets=0;//No of tickets
  String selectedClass = 'Select Here'; //select class for ticketd upgrade

//For current Location Select
  late double currentLatitude=0.0;
  late double currentLongitude=0.0;
  bool buttonPressed = false;

  TextEditingController updateTo = TextEditingController();


//********




  void updatesTextTo(String value) {
    setState(() {
      updateTo.text = value;
    });
  }






  @override
  Widget build(BuildContext context) {

    getDataFromFirestore();

    return Scaffold(

        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Upgrade Tickets'),

          backgroundColor: Colors.teal
        ),
        body: SingleChildScrollView(
            child:Column( children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 15, left: 12, right: 12, bottom: 15),
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



                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(

                    children: <Widget>[


                      const SizedBox(height: 25.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('National ID: $useridNumber', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                      Container(

                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('No of upgrade tickets :', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value1) {
                                setState(() {
                                  noUpgradeTickets = int.tryParse(value1) ?? 0;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: '$boughtTickets (Should be less than bought tickets)', // Display the ticket count as a hint
                              ),
                            ),
                          ],
                        ),
                      ),



                      const SizedBox(height: 20.0),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Row(
                          children: <Widget>[
                            const Text('Upgrade the class:         ', style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            DropdownButton<String>(
                              value: selectedClass,
                              onChanged: (value) {

                                // Check if 'noUpgradeTickets' is 0
                                if (noUpgradeTickets == 0) {
                                  // Show an error message for missing ticket amount
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white, // Background color of the AlertDialog
                                            borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                          ),
                                          child: AlertDialog(
                                            title: Text('Error'),
                                            content: Text('Please enter the amount of tickets.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if (noUpgradeTickets > noBokingTickets) {
                                  // Show an error message fr oinvalid ticket amount
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white, // Background color of the AlertDialog
                                            borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                          ),
                                          child: AlertDialog(
                                            title: Text('Error'),
                                            content: Text('Please valid enter the amount of tickets.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  // Reset 'noUpgradeTickets' to 0
                                  // noUpgradeTickets = 0;
                                } else {
                                  // Update the selected class
                                  setState(() {
                                    selectedClass = value!;
                                  });
                                }
                              },
                              items: <String>['Select Here', '2nd Class', '1st Class']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),



                      const SizedBox(height: 20.0),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            const Text('Add Current Location: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            ElevatedButton(
                              onPressed: () async {
                                if (selectedClass == 'Select Here') {
                                  // Show an error message for missing class selection
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white, // Background color of the AlertDialog
                                            borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                          ),
                                          child: AlertDialog(
                                            title: Text('Error'),
                                            content: Text('Please select the class.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  // If class is selected, proceed to get the current location
                                  getCurrentLocation();
                                  setState(() {
                                    buttonPressed = true;
                                  });
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: buttonPressed
                                    ? MaterialStateProperty.all<Color>(Colors.teal) // Change the color to your desired bold color
                                    : MaterialStateProperty.all<Color>(Colors.teal), // Set the default color
                              ),
                              child: Text('Click Here'),
                            ),
                          ],
                        ),
                      ),




                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 340,
                        height: 50,
                        margin: EdgeInsets.only(top: 70),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 32, 32, 33).withOpacity(0.5),
                              blurRadius: 5.0,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          onTap: () {
                            if (!buttonPressed) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white, // Background color of the AlertDialog
                                        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                      ),
                                      child: AlertDialog(
                                        title: Text('Error'),
                                        content: Text('Please press the button for get your location.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FromScreen(updatesTextTo),
                                ),
                              );
                            }
                          },
                          textAlign: TextAlign.left,
                          controller: updateTo,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            hintText: "Select Upgrade Point",
                            hintStyle: TextStyle(color: const Color.fromARGB(255, 13, 13, 13), fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 2),
                            ),
                            prefixIcon: Icon(Icons.location_pin, color: Color.fromARGB(255, 20, 20, 20)),
                          ),
                        ),
                      ),





                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (noUpgradeTickets == 0) {
                            // Show an error message for missing ticket amount
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white, // Background color of the AlertDialog
                                      borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                    ),
                                    child: AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Please enter the amount of tickets.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (noUpgradeTickets > noBokingTickets) {
                            // Show an error message fr oinvalid ticket amount
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white, // Background color of the AlertDialog
                                      borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                    ),
                                    child: AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Please enter valid the amount of tickets.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            // Reset 'noUpgradeTickets' to 0
                            // noUpgradeTickets = 0;
                          }else  if (selectedClass == 'Select Here') {
                            // Show an error message for missing class selection
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white, // Background color of the AlertDialog
                                      borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                    ),
                                    child: AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Please enter class.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }else if (!buttonPressed) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white, // Background color of the AlertDialog
                                      borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                    ),
                                    child: AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Please press button for get your location.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }else if (updateTo == '') {
                            // Show an error message for missing location
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white, // Background color of the AlertDialog
                                      borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                    ),
                                    child: AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Please select your destination.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else{
                            selectedDestinationLocation = await getLocationForDestination(updateTo.text); //w

                            print('Latitude: ${selectedDestinationLocation!.latitude}, Longitude: ${selectedDestinationLocation!.longitude}');


                            Position position = await getCurrentLocation(); // Y location
                            double distance = calculateDistance(position.latitude, position.longitude, destiLatitude, destintLongitude);
                            print('Distance: $distance');


                            if(bookingtrainType=='Normal'){
                              upgradenormalClass();
                            }
                            else if(bookingtrainType=='Intercity'){
                              upgradeIntercityClass();
                            }
                            total1=price1*noUpgradeTickets;   // total1= y to w price   x y z w
                            print('y to w price Total: $total1');

                            // Get Z
                            selectedbookingdestination = await getLocationForbookingdestination(bookingdestination);

                            if (selectedbookingdestination != null) {
                              print('Latitude: ${selectedbookingdestination!.latitude}, Longitude: ${selectedbookingdestination!.longitude}');

                            } else {
                              print('Location not found for the selected destination.');
                            }



// Calculate distance Y to Z    x y z w

                            if(bookingtrainType=='Normal'){
                              bookingTrainNormal();
                            }
                            else if(bookingtrainType=='Intercity'){
                              bookingTrainIntercity();
                            }

                            total2=price2*noUpgradeTickets; //y to z booking(privous price)
                            print('tatal2:$total2');
                            Total=total1+bookingTotal-total2; //BookingTotal= privious total price
                            //Total = overall total
                            print('Update Total :$Total');

                            payBalance=Total-bookingTotal;

                            print('You have to pay :$payBalance');



                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Payment(
                                noUpgradeTickets:noUpgradeTickets,
                                selectedClass:selectedClass,
                                updateTo:updateTo,
                                bookingtrainType:bookingtrainType,
                                Total: Total,
                                payBalance:payBalance,
                                nationalID: useridNumber,
                                distance:distance,
                              )),
                            );



                          }


                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal, // Change the button's background color to orange
                          elevation: 0.0,
                        ),



                        child: const Text('Submit'),



                      ),


                    ],
                  ),
                ),
              ),
            ],
            )





        )

    );
  }


  void resetForm() {
    setState(() {

      noUpgradeTickets = 0;
      selectedClass = 'Select Here';
      updateTo.text = '';
      // Reset other relevant variables as needed
    });
  }
















  Future<void> getDataFromFirestore() async {
    try {
      DocumentSnapshot documentSnapshot = await firestore.collection(useridNumber).doc('Booking details').get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

        // Access data using keys and store in variables
        bookingstart = data['From'] ?? '';
        bookingClass = data['Class'] ?? '';
        Date = data['date'] ?? '';
        bokindDistanceistance = (data['Distance'] is double) ? data['Distance'] : 0.0;
        noBokingTickets = int.tryParse(data['No Of Passenger'].toString()) ?? 0;
        bookingTotal = (data['Overall Total'] is double) ? data['Overall Total'] : 0.0;
        bookingdestination = data['To'] ?? '';
        bookingtrainType = data['Train Type'] ?? '';

        // Other variable assignments...

        print('Data retrieved successfully.');
        print('noBokingTickets: $noBokingTickets');

        print('$bookingClass');
        print('$bokindDistanceistance ');
        print('$bookingTotal');
        print('$bookingdestination');
        print('$bookingtrainType');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error getting data: $e');
    }
  }
  Future<Position> getCurrentLocation() async {
    // Check if the location permission is granted, and request it if not.
    if (!(await Permission.location.isGranted)) {
      final status = await Permission.location.request();
      if (status.isDenied) {
        // Handle the case where the user denied the location permission.
        print('Location permission is denied');
        throw Exception('Location permission denied');
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      currentLatitude = position.latitude;
      currentLongitude = position.longitude;
      print('Current Location: Latitude ${position.latitude}, Longitude ${position.longitude}');
      return position;
    } catch (e) {
      print('Error: $e');
      throw Exception('Error getting location: $e');
    }
  }



  Future<Location?> getLocationForDestination(String destination) async { //update destination
    try {
      List<Location> locations = await locationFromAddress(destination);
      if (locations.isNotEmpty) {
        destiLatitude = locations.first.latitude;
        destintLongitude = locations.first.longitude;
        return locations.first;
      } else {
        print('Location not found for destination: $destination');
        return null;
      }
    } catch (e) {
      print('Error getting location for destination: $e');
      return null;
    }
  }


  Future<Location?> getLocationForbookingdestination(String destination) async { //privious booking destination
    try {
      List<Location> locations = await locationFromAddress(destination);
      if (locations.isNotEmpty) {
        bookingdestiLatitude = locations.first.latitude;
        bookingdestintLongitude = locations.first.longitude;
        return locations.first;
      } else {
        print('Location not found for destination: $destination');
        return null;
      }
    } catch (e) {
      print('Error getting location for destination: $e');
      return null;
    }
  }


  double calculateDistance(double currentLatitude, double currentLongitude, double destiLatitude, double destintLongitude) {

    var p = 0.017453292519943295;
    var a = 0.5 - cos((destiLatitude - currentLatitude) * p) / 2 + cos(currentLatitude * p) * cos(destiLatitude * p) * (1 - cos((destintLongitude - currentLongitude) * p)) / 2;
    double distance = 12742 * asin(sqrt(a));
    return distance;
  }


  double upgradenormalClass(){

    double distance = calculateDistance(currentLatitude, currentLongitude, destiLatitude, destintLongitude);
    print('Y to W Distance: $distance');

    if(selectedClass=='1st Class'){


      if(distance<=10.0){
        price1= distance*10.4;
        if(price1<100){
          price1=100;
        }
      }
      else if(10 < distance && distance<=50.0){
        price1=104.0+ (distance-10.0)*9.60;
      }
      else if(50<distance  && distance <=100 ){
        price1=488.0+(distance-50.0)*6.80;
      }
      else if(100<distance  && distance <=200 ){
        price1=828.0+(distance-100.0)*5.6;
      }
      else if(200<distance ){
        price1=1388.0+(distance-200.0)*4.40;
      }
    }
    else if(selectedClass=='2nd Class'){
      if(distance<=10.0){
        price1= distance*5.2;
        if(price1<50){
          price1=50;
        }
      }
      else if(10 < distance && distance<=50.0){
        price1=52.0+ (distance-10.0)*4.8;
      }
      else if(50<distance  && distance <=100 ){
        price1=244.0+(distance-50.0)*3.4;
      }
      else if(100<distance  && distance <=200 ){
        price1=414.0+(distance-100.0)*2.8;
      }
      else if(200<distance ){
        price1=694.0+(distance-200.0)*2.2;
      }
    }

    return price1;
  }


  double upgradeIntercityClass(){
    double distance = calculateDistance(currentLatitude, currentLongitude, destiLatitude, destintLongitude);
    print('Y to W Distance: $distance');

    if(selectedClass=='1st Class'){


      if(distance<=10.0){
        price1= distance*10.4*2;
        if(price1<300){
          price1=300;
        }
      }
      else if(10 < distance && distance<=50.0){
        price1=(104.0+ (distance-10.0)*9.60)*3;
      }
      else if(50<distance  && distance <=100 ){
        price1=(488.0+(distance-50.0)*6.80)*3;
      }
      else if(100<distance  && distance <=200 ){
        price1=(828.0+(distance-100.0)*5.6)*3;
      }
      else if(200<distance ){
        price1=(1388.0+(distance-200.0)*4.40)*3;
      }
    }
    else if(selectedClass=='2nd Class'){

      if(distance<=10.0){
        price1= distance*10.4*2;
        if(price1<200){
          price1=200;
        }
      }
      else if(10 < distance && distance<=50.0){
        price1=(104.0+ (distance-10.0)*9.60)*2;
      }
      else if(50<distance  && distance <=100 ){
        price1=(488.0+(distance-50.0)*6.80)*2;
      }
      else if(100<distance  && distance <=200 ){
        price1=(828.0+(distance-100.0)*5.6)*2;
      }
      else if(200<distance ){
        price1=(1388.0+(distance-200.0)*4.40)*2;
      }
    }
    return price1;
  }

  double bookingTrainNormal(){

    double bookingdistance = calculateDistance(currentLatitude, currentLongitude, bookingdestiLatitude, bookingdestintLongitude);
    print('Y to Z booking Distance: $bookingdistance');

    if(bookingClass=='First Class'){
      print('hello') ;
      if(bookingdistance<=10.0){
        price2= bookingdistance*10.4;

      }
      else if(10 <bookingdistance && bookingdistance<=50.0){
        price2=104.0+ (bookingdistance-10.0)*9.60;
      }
      else if(50<bookingdistance  && bookingdistance <=100 ){
        price2=488.0+(bookingdistance-50.0)*6.80;
      }
      else if(100<bookingdistance  && bookingdistance <=200 ){
        price2=828.0+(bookingdistance-100.0)*5.6;
      }
      else if(200<bookingdistance ){
        price2=1388.0+(bookingdistance-200.0)*4.40;
      }
    }

    else if(bookingClass=='Second Class'){
      if(bookingdistance<=10.0){
        price2= bookingdistance*5.2;

      }
      else if(10 < bookingdistance && bookingdistance<=50.0){
        price2=52.0+ (bookingdistance-10.0)*4.8;
      }
      else if(50<bookingdistance  && bookingdistance <=100 ){
        price2=244.0+(bookingdistance-50.0)*3.4;
      }
      else if(100<bookingdistance  && bookingdistance <=200 ){
        price2=414.0+(bookingdistance-100.0)*2.8;
      }
      else if(200<bookingdistance ){
        price2=694.0+(bookingdistance-200.0)*2.2;
      }
    }

    else if(bookingClass=='Third Class'){
      if(bookingdistance<=10.0){
        price2= bookingdistance*2.6;

      }
      else if(10 < bookingdistance && bookingdistance<=50.0){
        price2=26.0+ (bookingdistance-10.0)*2.4;
      }
      else if(50<bookingdistance  && bookingdistance <=100 ){
        price2=122.0+(bookingdistance-50.0)*1.7;
      }
      else if(100<bookingdistance  && bookingdistance <=200 ){
        price2=207.0+(bookingdistance-100.0)*1.4;
      }
      else if(200<bookingdistance ){
        price2=347.0+(bookingdistance-200.0)*1.1;
      }
    }
    return price2;
  }



  double bookingTrainIntercity(){

    double bookingdistance = calculateDistance(currentLatitude, currentLongitude, bookingdestiLatitude, bookingdestintLongitude);
    print('Y to Z booking Distance: $bookingdistance');

    if(bookingClass=='First Class'){
      print('hello') ;
      if(bookingdistance<=10.0){
        price2= bookingdistance*10.4*3;

      }
      else if(10 <bookingdistance && bookingdistance<=50.0){
        price2=(104.0+ (bookingdistance-10.0)*9.60)*3;
      }
      else if(50<bookingdistance  && bookingdistance <=100 ){
        price2=(488.0+(bookingdistance-50.0)*6.80)*3;
      }
      else if(100<bookingdistance  && bookingdistance <=200 ){
        price2=(828.0+(bookingdistance-100.0)*5.6)*3;
      }
      else if(200<bookingdistance ){
        price2=(1388.0+(bookingdistance-200.0)*4.40)*3;

      }
    }

    else if(bookingClass=='Second Class'){
      if(bookingdistance<=10.0){
        price2= bookingdistance*10.4*2;

      }
      else if(10 <bookingdistance && bookingdistance<=50.0){
        price2=(104.0+ (bookingdistance-10.0)*9.60)*2;
      }
      else if(50<bookingdistance  && bookingdistance <=100 ){
        price2=(488.0+(bookingdistance-50.0)*6.80)*2;
      }
      else if(100<bookingdistance  && bookingdistance <=200 ){
        price2=(828.0+(bookingdistance-100.0)*5.6)*2;
      }
      else if(200<bookingdistance ){
        price2=(1388.0+(bookingdistance-200.0)*4.40)*2;

      }

    }

    else if(bookingClass=='Third Class'){
      if(bookingdistance<=10.0){
        price2= bookingdistance*10.4;

      }
      else if(10 <bookingdistance && bookingdistance<=50.0){
        price2=104.0+ (bookingdistance-10.0)*9.60;
      }
      else if(50<bookingdistance  && bookingdistance <=100 ){
        price2=488.0+(bookingdistance-50.0)*6.80;
      }
      else if(100<bookingdistance  && bookingdistance <=200 ){
        price2=828.0+(bookingdistance-100.0)*5.6;
      }
      else if(200<bookingdistance ){
        price2=1388.0+(bookingdistance-200.0)*4.40;
      }
    }
    return price2;
  }




}