import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedGender,
      hint: Text("Select Gender"),
      items: ['Male', 'Female', 'Other']
          .map((gender) => DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
    );
  }
}
