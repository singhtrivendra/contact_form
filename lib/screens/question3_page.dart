import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'submit_page.dart';

class Question3Page extends StatefulWidget {
  final int genderId; // Gender ID passed from Question 1
  final int age;      // Age passed from Question 2

  Question3Page({required this.genderId, required this.age});

  @override
  _Question3PageState createState() => _Question3PageState();
}

class _Question3PageState extends State<Question3Page> {
  File? _selfieImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _captureSelfie() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile != null) {
      setState(() {
        _selfieImage = File(pickedFile.path);
      });
    }
  }

  void _navigateToSubmitPage(BuildContext context) {
    // Capture additional required data here, e.g., GPS location and timestamp
    String gpsLocation = "26.12323,86.23235"; // Placeholder for GPS location
    String submitTime = DateTime.now().toString(); // Placeholder for current time

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubmitPage(
          genderId: widget.genderId,
          age: widget.age,
          selfieImage: _selfieImage,
          recordedAudio: null, // Replace with recorded audio file if available
          gpsLocation: gpsLocation,
          submitTime: submitTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Question 3: Upload Selfie')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Q3) Upload your selfie",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            // Show captured selfie or placeholder
            _selfieImage != null
                ? Column(
                    children: [
                      Image.file(
                        _selfieImage!,
                        width: 150,
                        height: 150,
                      ),
                      TextButton(
                        onPressed: _captureSelfie,
                        child: Text("Retake Selfie"),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: _captureSelfie,
                    child: Text("Capture Selfie"),
                  ),

            SizedBox(height: 20),

            // Next Button to navigate to Submit Page
            ElevatedButton(
              onPressed: () {
                // No validation required for Q3 as it’s optional
                _navigateToSubmitPage(context);
              },
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
