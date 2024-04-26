import 'package:aloria/screens/firstscreen.dart';
import 'package:aloria/screens/google.dart';
import 'package:aloria/screens/instruction/step.dart';
import 'package:aloria/screens/testresult.dart';
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
      home: TestResultsScreen(), // Set the SelfieScreen as the home screen
       debugShowCheckedModeBanner: false,
      // If you have more routes, define them here GoogleScreen SelfieScreen
    );
  }
}
