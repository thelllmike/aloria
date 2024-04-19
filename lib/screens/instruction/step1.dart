import 'package:flutter/material.dart';

class SelfieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Logo.png',
          width: 167, // Logo width
          height: 64, // Logo height
          fit: BoxFit.contain, // Ensure the entire logo is visible
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80, // Adjust the AppBar height as needed
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 285, // Width of the circular vector container
              height: 285, // Height of the circular vector container
              decoration: BoxDecoration(
                color: Color(0xFFC6C4FF).withOpacity(0.15), // Circle color with opacity
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: OverflowBox(
                maxWidth: 390, // Desired width of the image
                maxHeight: 390, // Desired height of the image
                child: Image.asset(
                  'assets/images/step1.png',
                  fit: BoxFit.cover, // Cover the area without changing the aspect ratio of the image
                ),
              ),
            ),
            SizedBox(height: 20), // Provide some spacing between the image and text
            Text(
              'STEP 1',
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Take a selfie! Make sure you’re in a well-lit area for the best shot',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement navigation to the next screen
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}