import 'package:flutter/material.dart';

import '../home/customer_support.dart';



class AskCommunity extends StatelessWidget {
  const AskCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ask community"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return const MyCustomerSupportPage();
              }));
            },
          ),
          backgroundColor: const Color.fromARGB(255, 47, 89, 227),
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: Colors.black12,
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "contents area...",
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}