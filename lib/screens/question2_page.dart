import 'package:flutter/material.dart';
import 'package:contact_form/screens/question3_page.dart';
import 'dart:io';

class Question2Page extends StatefulWidget {
  final int genderId; // Gender ID passed from Question 1
  final File? recordedAudio; // Audio file passed from Question1Page

  Question2Page({required this.genderId, this.recordedAudio});

  @override
  _Question2PageState createState() => _Question2PageState();
}

class _Question2PageState extends State<Question2Page> {
  final TextEditingController _ageController = TextEditingController();

  void _navigateToNextPage(BuildContext context) {
    String ageText = _ageController.text.trim();

    if (ageText.isEmpty || int.tryParse(ageText) == null) {
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
          builder: (context) => Question3Page(
            genderId: widget.genderId,
            age: age,
            recordedAudio: widget.recordedAudio, // Passing the audio file
          ),
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
            Text(" Type your age", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(), backgroundColor:  Color.fromARGB(255, 194, 4, 4),) ,
              onPressed: () => _navigateToNextPage(context),
              child: Text("Next",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
