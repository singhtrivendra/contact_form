import 'package:contact_form/screens/question2_page.dart';
import 'package:flutter/material.dart';

class Question1Page extends StatefulWidget {
  @override
  _Question1PageState createState() => _Question1PageState();
}

class _Question1PageState extends State<Question1Page> {
  int? _selectedGenderId; // Gender selection (1 for Male, 2 for Female, 3 for Other)

  final List<Map<String, dynamic>> genderOptions = [
    {"id": 1, "label": "Male"},
    {"id": 2, "label": "Female"},
    {"id": 3, "label": "Other"},
  ];

  void _navigateToNextPage(BuildContext context) {
    if (_selectedGenderId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Question2Page(genderId: _selectedGenderId!),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Question 1: Select Gender')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Q1) Select your gender",
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
              onPressed: () => _navigateToNextPage(context),
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
