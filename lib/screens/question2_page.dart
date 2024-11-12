import 'package:contact_form/screens/question3_page.dart';
import 'package:flutter/material.dart';

class Question2Page extends StatefulWidget {
  final int genderId; // Gender ID passed from Question 1

  Question2Page({required this.genderId});

  @override
  _Question2PageState createState() => _Question2PageState();
}

class _Question2PageState extends State<Question2Page> {
  final TextEditingController _ageController = TextEditingController();

  void _navigateToNextPage(BuildContext context) {
    String ageText = _ageController.text.trim();

    // Validate if the age input is not empty and is a number
    if (ageText.isEmpty || int.tryParse(ageText) == null) {
      // Show error if age is invalid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter a valid age'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      int age = int.parse(ageText);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Question3Page(genderId: widget.genderId, age: age),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Question 2: Enter Your Age')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Q2) Type your age",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number, // Only numbers allowed
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToNextPage(context),
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
