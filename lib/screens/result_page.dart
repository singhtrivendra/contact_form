import 'package:flutter/material.dart';
import 'dart:io';

class ResultPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // Display gender based on ID
    String genderText;
    if (genderId == 1) {
      genderText = 'Male';
    } else if (genderId == 2) {
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
                        child: Text(age.toString()),
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
                        child: selfieImage != null
                            ? Image.file(
                                selfieImage!,
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
                        child: recordedAudio != null
                            ? Text("Audio file recorded")
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
                        child: Text(gpsLocation),
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
                        child: Text(submitTime),
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
