import 'package:flutter/material.dart';
import 'dart:io';
import 'result_page.dart';

class SubmitPage extends StatelessWidget {
  final int genderId; // Gender ID from the gender selection (e.g., 1 for Male, 2 for Female, etc.)
  final int age; // Age input from the user
  final File? selfieImage; // Selfie image captured by the user
  final File? recordedAudio; // Audio recording file
  final String gpsLocation; // GPS location in format "latitude, longitude"
  final String submitTime; // Submission time in format "Y-m-d H:i:s"

  SubmitPage({
    required this.genderId,
    required this.age,
    this.selfieImage,
    this.recordedAudio,
    required this.gpsLocation,
    required this.submitTime,
  });

  void _navigateToResultPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          genderId: genderId,
          age: age,
          selfieImage: selfieImage,
          recordedAudio: recordedAudio,
          gpsLocation: gpsLocation,
          submitTime: submitTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Confirm your submission details below",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToResultPage(context);
              },
              child: Text('Submit and View Results'),
            ),
          ],
        ),
      ),
    );
  }
}
