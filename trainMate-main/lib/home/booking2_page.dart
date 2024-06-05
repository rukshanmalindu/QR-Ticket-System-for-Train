import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../booking/fromscreen_page.dart';
import '../booking/paymentbooking.dart';
import '../booking/toscreen_page.dart';


class SEARCH extends StatefulWidget {
  final String initialText1;
  final String initialText2;
  SEARCH({Key? key, required this.initialText1, required this.initialText2}) : super(key: key);


  @override
  _SEARCHState createState() => _SEARCHState();
}

class _SEARCHState extends State<SEARCH> {
  TextEditingController textFrom = TextEditingController();
  TextEditingController textTo = TextEditingController();
  TextEditingController textNo_Of_Pasenger = TextEditingController();
  // TextEditingController selectedItem1 = TextEditingController();
  // TextEditingController selectedItem2 = TextEditingController();
  // TextEditingController distance= TextEditingController();



  double bookcurrentLatitude=0.0;
  late double bookcurrentLongitude;
  late double bookdestiLatitude;
  late double bookdestintLongitude;
  double bookprice=0;
  late double totalBookPrice;
  get databaseReference => null;
  late double bookdistance;

  double calculateDistance(double bookcurrentLatitude, double bookcurrentLongitude, double bookdestiLatitude, double bookdestintLongitude) {

    var p = 0.017453292519943295;
    var a = 0.5 - cos((bookdestiLatitude - bookcurrentLatitude) * p) / 2 + cos(bookcurrentLatitude * p) * cos(bookdestiLatitude * p) * (1 - cos((bookdestintLongitude - bookcurrentLongitude) * p)) / 2;
    double distance = 12742 * asin(sqrt(a));
    return distance;
  }



  Future<Location?> getLocationForAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {



        return locations.first;
      } else {
        print('Location not found for address: $address');
        return null;
      }
    } catch (e) {
      print('Error getting location for address: $e');
      return null;
    }
  }



  void updateTextFrom(String value) {
    setState(() {
      textFrom.text = value;
    });
  }

  void updateTextTo(String value) {
    setState(() {
      textTo.text = value;
    });
  }


  //Date
  late DateTime date = DateTime.now();
  void getDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000)
    ).then((value) {
      setState(() {
        date = value!;
      });
    });
  }

  void updateDateForTomorrow() {
    setState(() {
      date = date.add(Duration(days: 1));
    });
  }


  Color cardColor = Colors.white;

  String selectedItem1 = 'Normal';
  List<String> dropdownItems1 = ['Normal', 'Intercity'];

  String selectedItem2 = 'Third Class';
  List<String> dropdownItems2 = ['First Class', 'Second Class', 'Third Class'];


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
        ),
        body:Container(
            child: SingleChildScrollView(
              child: Column(
                  children:[
                    Stack(
                      children: [
                        Positioned(
                            child: Container(
                              color: Colors.teal,
                              height: 350,
                              width: w,
                              child:
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                      left: 10,
                                      top: 20,
                                      child: Text(
                                        "Book your Tickets",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 22),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),



                                  Positioned(
                                    width: 340,
                                    height: 50,
                                    top: 70,
                                    child: TextField(

                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FromScreen(updateTextFrom),
                                          ),
                                        );


                                      },
                                      textAlign: TextAlign.left,
                                      controller: textFrom,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "From",
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(color: Colors.white,width: 2)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(color: Colors.white,width: 2)
                                        ),
                                        prefixIcon: Icon(Icons.my_location_sharp,color: Colors.teal),
                                      ),
                                      //style: TextStyle(color: Colors.black,fontSize: 15 ),
                                      //autofocus: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Positioned(
                                    top:104,
                                    left: 280,
                                    child:IconButton(
                                      icon: Icon(Icons.swap_vert_circle),
                                      onPressed: () {
                                        // Swap text field data
                                        String temp = textFrom.text;
                                        textFrom.text = textTo.text;
                                        textTo.text = temp;
                                      },
                                      color: Colors.white,
                                      iconSize: 45,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Positioned(
                                    width: 340,
                                    height: 50,
                                    top: 150,
                                    child: TextField(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ToScreen(updateTextTo),
                                          ),
                                        );
                                      },

                                      controller: textTo,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "To",
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(color: Colors.white,width: 2)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(color: Colors.white,width: 2)
                                        ),
                                        prefixIcon: Icon(Icons.location_pin, color: Colors.teal),
                                      ),
                                      //style: TextStyle(color: Colors.black,fontSize: 15 ),
                                      //autofocus: true,
                                    ),
                                  ),
                                  Positioned(
                                    top:217,
                                    left: 240,
                                    child: TextButton(
                                        onPressed: updateDateForTomorrow,
                                        child: Text("Tomorrow", style: TextStyle(fontSize: 17, color: Colors.white))
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Stack(
                                    children: [
                                      Positioned(
                                        left: 10,
                                        top: 220,
                                        child: Container(
                                          width: 220,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                onPressed: (){
                                                  getDatePicker();
                                                },
                                                icon: Icon(Icons.calendar_month, color: Colors.teal, size: 28,),
                                              ),
                                              Text(date.day.toString()+'/'+date.month.toString()+'/'+date.year.toString(), style: TextStyle(fontSize: 18),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    width: 340,
                                    height: 50,
                                    top: 280,
                                    child: TextField(
                                      controller: textNo_Of_Pasenger,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "No of Passengers",
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(color: Colors.white,width: 2)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(color: Colors.white,width: 2)
                                        ),
                                        prefixIcon: Icon(Icons.people, color: Colors.teal),
                                      ),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.black,fontSize: 15,  ),
                                      //autofocus: true,
                                    ),
                                  ),
                                  /*,),
                            ),
                          ),
                    ),*/
                                ],
                              ),
                            )
                        ),

                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        "You Can Also Book",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 270,
                      height: 65,
                      alignment: Alignment.centerRight,
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_drop_down_circle, color: Colors.teal),
                        iconSize: 27,
                        value: selectedItem1,
                        items: dropdownItems1.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedItem1 = newValue!;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: "Types of Trains",
                            border: UnderlineInputBorder()
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 300,
                      height: 65,
                      alignment: Alignment.bottomRight,
                      child: DropdownButtonFormField<String>(
                        padding: EdgeInsets.only(left:16, right: 16),
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_drop_down_circle, color: Colors.teal),
                        iconSize: 27,
                        value: selectedItem2,
                        items: dropdownItems2.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedItem2 = newValue!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Class of Train ",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(240, 40),
                          primary: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                          ),
                        ),
                        onPressed: () async {

                          final fromLocation = await getLocationForAddress(textFrom.text);
                          if (fromLocation != null) {
                            print('From Location: Latitude: ${fromLocation.latitude}, Longitude: ${fromLocation.longitude}');
                            bookcurrentLatitude=fromLocation.latitude;
                            bookcurrentLongitude=fromLocation.longitude;
                          } else {
                            print('Location not found for "From" address.');
                          }

                          final toLocation = await getLocationForAddress(textTo.text);

                          if (toLocation != null) {
                            print('To Location: Latitude: ${toLocation.latitude}, Longitude: ${toLocation.longitude}');
                            bookdestiLatitude=toLocation.latitude;
                            bookdestintLongitude=toLocation.longitude;
                          } else {
                            print('Location not found for "To" address.');
                          }


                          bookdistance = calculateDistance(bookcurrentLatitude, bookcurrentLongitude, bookdestiLatitude, bookdestintLongitude);
                          print('Distance: $bookdistance');


                          if(selectedItem1=='Normal'){
                            if(selectedItem2=='First Class'){
                              print('hello') ;
                              if(bookdistance<=10.0){
                                bookprice= bookdistance*10.4;
                                if( bookprice<100){
                                  bookprice=100;
                                  print('hello2') ;
                                }
                              }
                              else if(10 <bookdistance && bookdistance<=50.0){
                                bookprice=104.0+ (bookdistance-10.0)*9.60;
                              }
                              else if(50<bookdistance  && bookdistance <=100 ){
                                bookprice=488.0+(bookdistance-50.0)*6.80;
                              }
                              else if(100<bookdistance  && bookdistance <=200 ){
                                bookprice=828.0+(bookdistance-100.0)*5.6;
                              }
                              else if(200<bookdistance ){
                                bookprice=1388.0+(bookdistance-200.0)*4.40;
                              }
                            }

                            else if(selectedItem2=='Second Class'){
                              if(bookdistance<=10.0){
                                bookprice= bookdistance*5.2;
                                if( bookprice<50){
                                  bookprice=50;
                                }
                              }
                              else if(10 < bookdistance && bookdistance<=50.0){
                                bookprice=52.0+ (bookdistance-10.0)*4.8;
                              }
                              else if(50<bookdistance  && bookdistance <=100 ){
                                bookprice=244.0+(bookdistance-50.0)*3.4;
                              }
                              else if(100<bookdistance  && bookdistance <=200 ){
                                bookprice=414.0+(bookdistance-100.0)*2.8;
                              }
                              else if(200<bookdistance ){
                                bookprice=694.0+(bookdistance-200.0)*2.2;
                              }
                            }

                            else if(selectedItem2=='Third Class'){
                              if(bookdistance<=10.0){
                                bookprice= bookdistance*2.6;
                                if( bookprice<20){
                                  bookprice=20;
                                }
                              }
                              else if(10 < bookdistance && bookdistance<=50.0){
                                bookprice=26.0+ (bookdistance-10.0)*2.4;
                              }
                              else if(50<bookdistance  && bookdistance <=100 ){
                                bookprice=122.0+(bookdistance-50.0)*1.7;
                              }
                              else if(100<bookdistance  && bookdistance <=200 ){
                                bookprice=207.0+(bookdistance-100.0)*1.4;
                              }
                              else if(200<bookdistance ){
                                bookprice=347.0+(bookdistance-200.0)*1.1;
                              }
                            }
                          }
                          else if(selectedItem1=='Intercity'){

                            if(selectedItem2=='Third Class'){

                              if(bookdistance<=10.0){
                                bookprice= bookdistance*10.4;
                                if( bookprice<100){
                                  bookprice=100;
                                }
                              }
                              else if(10 <bookdistance && bookdistance<=50.0){
                                bookprice=104.0+ (bookdistance-10.0)*9.60;
                              }
                              else if(50<bookdistance  && bookdistance <=100 ){
                                bookprice=488.0+(bookdistance-50.0)*6.80;
                              }
                              else if(100<bookdistance  && bookdistance <=200 ){
                                bookprice=828.0+(bookdistance-100.0)*5.6;
                              }
                              else if(200<bookdistance ){
                                bookprice=1388.0+(bookdistance-200.0)*4.40;
                              }
                            }

                            else if(selectedItem2=='Second Class'){
                              if(bookdistance<=10.0){
                                bookprice= bookdistance*20.8;
                                if( bookprice<200){
                                  bookprice=200;
                                }
                              }
                              else if(10 <bookdistance && bookdistance<=50.0){
                                bookprice=(104.0+ (bookdistance-10.0)*9.60)*2;
                              }
                              else if(50<bookdistance  && bookdistance <=100 ){
                                bookprice=(488.0+(bookdistance-50.0)*6.80)*2;
                              }
                              else if(100<bookdistance  && bookdistance <=200 ){
                                bookprice=(828.0+(bookdistance-100.0)*5.6)*2;
                              }
                              else if(200<bookdistance ){
                                bookprice=(1388.0+(bookdistance-200.0)*4.40)*2;
                              }
                            }

                            else if(selectedItem2=='First Class'){
                              if(bookdistance<=10.0){
                                bookprice= bookdistance*20.8;
                                if( bookprice<300){
                                  bookprice=300;
                                }
                              }
                              else if(10 <bookdistance && bookdistance<=50.0){
                                bookprice=(104.0+ (bookdistance-10.0)*9.60)*3;
                              }
                              else if(50<bookdistance  && bookdistance <=100 ){
                                bookprice=(488.0+(bookdistance-50.0)*6.80)*3;
                              }
                              else if(100<bookdistance  && bookdistance <=200 ){
                                bookprice=(828.0+(bookdistance-100.0)*5.6)*3;
                              }
                              else if(200<bookdistance ){
                                bookprice=(1388.0+(bookdistance-200.0)*4.40)*3;
                              }
                            }

                          }

                          print('hellobookprice');
                          print('${bookprice}');
                          int passengerCount = int.tryParse(textNo_Of_Pasenger.text) ?? 0;
                          print('hellobookprice32');
                          totalBookPrice=bookprice*passengerCount;
                          print("${totalBookPrice}");



/*

                FirebaseFirestore firestore = FirebaseFirestore.instance;
                CollectionReference collection = firestore.collection('${x++}');


String customDocumentName = 'Tickets details';
                // Create a map with data
                Map<String, dynamic> data = {
                  "From":textFrom.text,
                  "To":textTo.text,
                 "Distance":bookdistance,
                  "No Of Passenger":textNo_Of_Pasenger.text,
                  "Class": selectedItem2,
                  "Train Type":selectedItem1,
                  "Date":date,
                 "Total Bookin Price":totalBookPrice,

                };

                collection.doc(customDocumentName).set(data).then((_) {

                  print('Data added to Firestore');
                }).catchError((error) {

                  print('Error adding data to Firestore: $error');
                });

*/




                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PaymentBooking(
                              textFrom:textFrom.text,
                              To:textTo.text,
                              Distance:bookdistance,
                              No_Of_Passenger:textNo_Of_Pasenger.text,
                              trainclass: selectedItem2, //class
                              Train_Type:selectedItem1,
                              Date:date,
                              Total_Bookin_Price:totalBookPrice,
                              bookdistance:bookdistance,

                            )),
                          );















                          // Get the values from the TextFields and the date
                          String fromValue = textFrom.text;
                          String toValue = textTo.text;
                          String dateValue = date.toIso8601String(); // Convert date to a string

                          // Create a map with the data you want to send
                          Map<String, dynamic> tripData = {
                            "from": fromValue,
                            "to": toValue,
                            "date": dateValue,
                          };

                          // Send data to Firebase database
                          //databaseReference.child("trips").push().set(tripData).then((_) {
                          // Data sent successfully
                          //print("Data sent to Firebase");
                          //}).catchError((error) {
                          // Handle any errors
                          //print("Error sending data to Firebase: $error");
                          //});



                          //Clear data


                          //DropdownMenuItem Update


                          //Update date
                          setState(() {
                            date = DateTime.now();
                          });

                        },
                        child: Text('Book Tickets'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Return Trip",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: w - 20,
                      height: 70,
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: 20,
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Maradana to Ambalangoda",
                                style:
                                TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                  onPressed: () async {

                                  },



                                child: Text(
                                  "Book Now",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.teal, // Change the text color to white
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ]
              ),
            )
        )
    );
  }

/*Future<String> getTravelDuration(String from, String to) async {
    final apiKey = 'YOUR_GOOGLE_MAPS_API_KEY'; // Replace with your API key
    final baseUrl = 'https://maps.googleapis.com/maps/api/distancematrix/json';

    final response = await http.get(Uri.parse(
      '$baseUrl?origins=$from&destinations=$to&key=$apiKey',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rows = data['rows'] as List;
      if (rows.isNotEmpty) {
        final elements = rows[0]['elements'] as List;
        if (elements.isNotEmpty) {
          final duration = elements[0]['duration']['text'] as String;
          return duration;
        }
      }
    }

    return 'N/A';
  }*/

}