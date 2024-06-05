import 'package:flutter/material.dart';
import 'package:untitled12/home/customer_support.dart';
import 'package:untitled12/login/home_page.dart';
import 'package:untitled12/login/profile_page.dart';
import 'qr.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key});

  @override
  State<Navigation> createState() => _HomeState();
}

class _HomeState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Home(),
    MyCustomerSupportPage(),
    Qr(),
    ProfilePage(),
    MyCustomerSupportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 0,vertical: 0), // Add margin to the bottom of the BottomNavigationBar
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.teal,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
                size: 28,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.contact_page,
                color: Colors.black,
                size: 28,
              ),
              label: 'Contact',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code,
                color: Colors.black,
                size: 28,
              ),
              label: 'QR',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
                size: 28,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      )

    );

  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Tab Content'),
      ),
    );
  }
}

class ContactTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Center(
        child: Text('Contact Tab Content'),
      ),
    );
  }
}

class QRTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR'),
      ),
      body: Center(
        child: Text('QR Tab Content'),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile Tab Content'),
      ),
    );
  }
}
