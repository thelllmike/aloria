import 'package:aloria/screens/instruction/step1.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aloria',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SelfieScreen(), // Set the SelfieScreen as the home screen
      // If you have more routes, define them here
    );
  }
}
