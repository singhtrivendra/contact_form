import 'package:flutter/material.dart';
import 'dart:io';
import 'result_page.dart'; // Ensure you import the ResultPage

class SubmitPage extends StatelessWidget {
  final int genderId;
  final int age;
  final File? selfieImage;
  final File? recordedAudio; // The recorded audio file
  final String gpsLocation;
  final String submitTime;

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
          recordedAudio: recordedAudio, // Passing the recorded audio
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
            Text("Confirm your submission details below", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(), backgroundColor:  Color.fromARGB(255, 194, 4, 4),) ,
              onPressed: () {
                _navigateToResultPage(context);
              },
              child: Text('Submit and View Results',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
