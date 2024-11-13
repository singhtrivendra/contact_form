import 'package:flutter/material.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'question2_page.dart';

class Question1Page extends StatefulWidget {
  @override
  _Question1PageState createState() => _Question1PageState();
}

class _Question1PageState extends State<Question1Page> {
  int? _selectedGenderId; // Gender selection (1 for Male, 2 for Female, 3 for Other)
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool _isRecording = false;
  File? _recordedAudioFile;

  final List<Map<String, dynamic>> genderOptions = [
    {"id": 1, "label": "Male"},
    {"id": 2, "label": "Female"},
    {"id": 3, "label": "Other"},
  ];

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    // Request microphone permission
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      await _audioRecorder.openRecorder();
      _startRecording();
    } else {
      // Show a message if permission is not granted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Microphone permission is required to record audio")),
      );
    }
  }

  Future<void> _startRecording() async {
    final String path = '/storage/emulated/0/Download/recording.wav';
    await _audioRecorder.startRecorder(
      toFile: path,
      codec: Codec.pcm16WAV,
    );
    setState(() {
      _isRecording = true;
    });
    _recordedAudioFile = File(path);
  }

  Future<void> _stopRecording() async {
    if (_isRecording) {
      await _audioRecorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    }
  }

  void _navigateToNextPage(BuildContext context) async {
    if (_selectedGenderId != null) {
      await _stopRecording(); // Stop recording before navigating
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Question2Page(
            genderId: _selectedGenderId!,
            recordedAudio: _recordedAudioFile, // Pass the recorded audio file
          ),
        ),
      );
    } else {
      // Show an error message if no gender is selected
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please select your gender'),
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
    }
  }

  @override
  void dispose() {
    _stopRecording();
    _audioRecorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Question 1: Select Gender')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " Select your gender",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              DropdownButton<int>(
                value: _selectedGenderId,
                hint: Text("Choose Gender"),
                items: genderOptions
                    .map(
                      (option) => DropdownMenuItem<int>(
                        value: option["id"],
                        child: Text(option["label"]),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGenderId = value;
                  });
                },
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
      ),
    );
  }
}
