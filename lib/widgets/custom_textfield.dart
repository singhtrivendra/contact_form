import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Enter your age'),
    );
  }
}
