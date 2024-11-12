import 'package:flutter/material.dart';
import 'screens/question1_page.dart';

void main() {
  runApp(ContactFormApp());
}

class ContactFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Form App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Question1Page(),
    );
  }
}
