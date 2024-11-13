import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class ResultPage extends StatefulWidget {
  final int genderId; // 1 for Male, 2 for Female, 3 for Other
  final int age;
  final File? selfieImage;
  final File? recordedAudio;
  final String gpsLocation;
  final String submitTime;

  ResultPage({
    required this.genderId,
    required this.age,
    this.selfieImage,
    this.recordedAudio,
    required this.gpsLocation,
    required this.submitTime,
  });

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      await _audioPlayer.openPlayer();
      _audioPlayer.onProgress!.listen((event) {
        if (event.position == event.duration) {
          setState(() {
            isPlaying = false;
          });
        }
      });
    } else {
      // Handle the case when permission is denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Microphone permission is required to play audio")),
      );
    }
  }

  Future<void> _playAudio() async {
    if (widget.recordedAudio != null) {
      setState(() {
        isPlaying = true;
      });
      await _audioPlayer.startPlayer(
        fromURI: widget.recordedAudio!.path,
        codec: Codec.pcm16WAV,
        whenFinished: () {
          setState(() {
            isPlaying = false;
          });
        },
      );
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stopPlayer();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    _audioPlayer.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String genderText;
    if (widget.genderId == 1) {
      genderText = 'Male';
    } else if (widget.genderId == 2) {
      genderText = 'Female';
    } else {
      genderText = 'Other';
    }

    return Scaffold(
      appBar: AppBar(title: Text("Submission Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Submitted Data",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Question", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Answer", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Gender"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(genderText),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Age"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.age.toString()),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Selfie"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.selfieImage != null
                            ? Image.file(
                                widget.selfieImage!,
                                width: 100,
                                height: 100,
                              )
                            : Text("No selfie taken"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Recorded Audio"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.recordedAudio != null
                            ? Column(
                                children: [
                                  Text("Audio file recorded"),
                                  IconButton(
                                    icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                                    onPressed: () {
                                      isPlaying ? _stopAudio() : _playAudio();
                                    },
                                  ),
                                ],
                              )
                            : Text("No audio recorded"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("GPS Location"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.gpsLocation),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Submission Time"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.submitTime),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
