import 'package:flutter/material.dart';

import 'addcard.dart';


class RechargeAccountPage extends StatefulWidget {
  const RechargeAccountPage({super.key});

  @override
  _RechargeAccountPageState createState() => _RechargeAccountPageState();
}

class _RechargeAccountPageState extends State<RechargeAccountPage> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  // Function to recharge the user's account
  void _rechargeAccount() {
    // Add your logic here to process the recharge, e.g., communicate with a payment gateway
    // You can also validate the amount and handle any errors or success messages
    // For this example, we'll simply show a dialog with a success message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Recharge Successful'),
          content: const Text('Your account has been successfully recharged.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // You can navigate back to the previous screen or perform other actions here
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recharge Account'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter the amount you want to recharge:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.monetization_on),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _rechargeAccount();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCardPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Change the button's background color to orange
                elevation: 0.0,
              ),
              child: const Text('Recharge'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: RechargeAccountPage(),
  ));
}