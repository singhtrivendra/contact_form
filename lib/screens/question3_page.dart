import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'submit_page.dart'; // Ensure to import the SubmitPage
import 'package:flutter_sound/flutter_sound.dart'; // Import for FlutterSound for audio playback

class Question3Page extends StatefulWidget {
  final int genderId; // Gender ID passed from Question 1
  final int age; // Age passed from Question 2
  final File? recordedAudio; // Audio file passed from Question 1
  final File? selfieImage; // Selfie image from Question 2

  Question3Page({
    required this.genderId,
    required this.age,
    this.recordedAudio,
    this.selfieImage,
  });

  @override
  _Question3PageState createState() => _Question3PageState();
}

class _Question3PageState extends State<Question3Page> {
  final ImagePicker _picker = ImagePicker();
  File? _selfieImage; // Holds the selfie image from the camera

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

  Future<void> _navigateToSubmitPage(BuildContext context) async {
    // Capture additional required data like GPS location and timestamp
    String gpsLocation = "26.12323,86.23235"; // Placeholder for GPS location
    String submitTime = DateTime.now().toString(); // Placeholder for current time

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubmitPage(
          genderId: widget.genderId,
          age: widget.age,
          selfieImage: _selfieImage ?? widget.selfieImage, // Use the captured selfie or passed selfie
          recordedAudio: widget.recordedAudio, // Pass the recorded audio
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " Upload your selfie",
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
                          style: TextButton.styleFrom(shape: RoundedRectangleBorder(), backgroundColor:  Color.fromARGB(255, 194, 4, 4),),
                          onPressed: _captureSelfie,
                          child: Text("Retake Selfie",style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    )
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(), backgroundColor:  Color.fromARGB(255, 194, 4, 4),) ,
                      onPressed: _captureSelfie,
                      child: Text("Capture Selfie",style: TextStyle(color: Colors.white),),
                    ),
          
              SizedBox(height: 20),
          
              // Display the recorded audio (if available)
              widget.recordedAudio != null
                  ? Column(
                      children: [
                        // Text("Audio File: ${widget.recordedAudio!.path}"),
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     // You can play the recorded audio here using FlutterSound
                        //     FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();
                        //     await _audioPlayer.startPlayer(
                        //         fromURI: widget.recordedAudio!.path);
                        //   },
                        //   child: Text("Play Recorded Audio"),
                        // ),
                      ],
                    )
                  : Text("No audio recorded"),
          
              SizedBox(height: 20),
          
              // Next Button to navigate to Submit Page
              ElevatedButton(
                              style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(), backgroundColor:  Color.fromARGB(255, 194, 4, 4),) ,
                onPressed: () {
                  _navigateToSubmitPage(context); // Call the updated function
                },
                child: Text("Next",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
