import 'package:flutter/material.dart';

class SelfieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Logo.png',
          width: 167,
          height: 64,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: Stack(
        children: <Widget>[
          // Content of the page
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Container(
                width: 285,
                height: 285,
                decoration: BoxDecoration(
                  color: Color(0xFFC6C4FF).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: OverflowBox(
                  maxWidth: 390,
                  maxHeight: 390,
                  child: Image.asset(
                    'assets/images/step1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'STEP 1',
                style: TextStyle(
                  fontFamily: 'Bebas Neue',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Take a selfie! Make sure you’re in a \n well-lit area for the best shot',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.125,
                  ),
                ),
              ),
              Spacer(),
              // Page indicator
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (index) {
                  return Container(
                    width: index == 0 ? 64 : 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: index == 0 ? Color(0xFF403D3D1A) : Color(0xFF403D3D1A).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20), // Space before the button

                            Container(
                width: double.infinity, // Make the container take the full width of the screen
                height: 1.2,
                color: Color(0xFF403D3D), // Border color
              ),
SizedBox(height: 20), 
              // Next button
              Container(
                width: double.infinity, // Makes the button stretch to the screen width
                padding: EdgeInsets.symmetric(horizontal: 29),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF77BF43),
                    onPrimary: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    // TODO: Implement button click action
                  },
                  child: Text('Next'),
                ),
              ),
              SizedBox(height: 34), // Space at the bottom
            ],
          ),
        ],
      ),
    );
  }
}