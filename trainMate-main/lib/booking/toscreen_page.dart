import 'package:flutter/material.dart';
import '../home/booking2_page.dart';
/*
class FromScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title:
        Positioned(
          top: 0,
          left: 10,
          child: Row(
          children: [
            Text('From', style: TextStyle(fontSize: 20)), // Your title
          ],
        ),
        // Other properties and widgets go here.
      ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Text(
              'This is your new screen!',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),*/
          ],
        ),
      ),
    );
  }
}*/

final suggestedlist = [
  'Maradana',
  'Dematagoda',
  'Kelaniya',
  'Wanawasala',
  'Hunupitiya',
  'Enderamulla',
  'Horape',
  'Ragama',
  'Walpola',
  'Batuwatte',
  'Bulugahagoda',
  'Ganemulla',
  'Yagoda',
  'Gampaha',
  'Daraluwa',
  'Bemmulla',
  'Magelegoda',
  'Heendeniya',
  'Veyangoda',
  'Wandurawa',
  'Keenawal',
  'Pallewala',
  'Ganegoda',
  'Wijayarajadahana',
  'Mihirigama',
  'Wilwatte',
  'Botale',
  'Abeypussa',
  'Yattalgoda',
  'Buthgamuwa',
  'Alawwa',
  'Wlakubura',
  'Poplgahawela',
  'Panaleeya',
  'Tismalpola',
  'Yatagama',
  'Rambukkana',
  'Kadigamuwa',
  'Gangoda',
  'Ihalakotte',
  'Balana',
  'Kadugannawa',
  'Pilimatalawa',
  'Peradeniya',
  'Koshinna',
  'Gelioya',
  'Gampol',
  'Tembligala',
  'Ulapone',
  'Nawalapitiya',
  'Inguruoya',
  'Galaboda',
  'Watawala',
  'Ihalawatawala',
  'Rosella',
  'Hatton',
  'Kotagala',
];

class ToScreen extends StatefulWidget {
  final Function(String) onToSelected;
  ToScreen(this.onToSelected);

  @override
  State<ToScreen> createState() => ToScreenState();
}

class ToScreenState extends State<ToScreen> {
  TextEditingController textcontroller = TextEditingController();
  List<String> filteredlist = suggestedlist;

  void navigateToSecondPage(String selectedValue) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SEARCH(initialText1: textcontroller.text, initialText2: selectedValue),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(context: context, delegate: mysearchdelegate());
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.search),
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Container(
                width: 340,
                height: 50,
                child: TextField(
                  controller: textcontroller,
                  onChanged: (value) {
                    filteredlist = suggestedlist.where((element) {
                      final filtering = element.toLowerCase().contains(value);
                      return filtering;
                    }).toList();
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.grey), // Change the border color here
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      //borderSide: BorderSide(color: Colors.blue), // Change the border color when focused
                    ),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search,color: Colors.blue),
                    suffixIcon: textcontroller.text.isNotEmpty
                        ? Container(
                      width: 50, // Set the width to your desired size
                      height: 50, // Set the height to your desired size
                      child: IconButton(
                        icon: Icon(Icons.close_rounded),
                        onPressed: () {
                          textcontroller.clear();
                          // Optionally, you can clear the filtered list and update the UI.
                          filteredlist = suggestedlist;
                          setState(() {});
                        },
                      ),
                    )
                        : null,
                  ),
                  textInputAction: TextInputAction.search,
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: filteredlist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredlist[index]),
                      onTap: () {
                        widget.onToSelected(filteredlist[index]);
                        Navigator.pop(context);
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>(
                                  initialText2: filteredlist[index],
                                )));*/
                      },
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}