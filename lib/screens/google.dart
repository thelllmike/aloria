import 'package:aloria/screens/firstscreen.dart';
import 'package:aloria/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Make sure this package is added to your pubspec.yaml

class GoogleScreen extends StatelessWidget {
  const GoogleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen for relative sizing
    Size screenSize = MediaQuery.of(context).size;

    // Calculate the offsets based on the changes
    double logoBottomOffset = screenSize.height * 0.15; // Logo closer to the button
    double logoHorizontalOffset = (screenSize.width - 167) / 2; // Centers the logo horizontally
    double buttonBottomOffset = screenSize.height * 0.04; // Bottom offset of the button

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image moved to top
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/images/googlegirl.png', // Make sure this is the correct path to your image
              width: screenSize.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          // Positioned white container with gradient effect
          Positioned(
            bottom: 0,
            child: Container(
              width: screenSize.width,
              height: screenSize.height * 0.8, // Height is 80% of the screen height
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xFFFFF8F7)],
                  stops: [0.5221, 0.78],
                ),
              ),
            ),
          ),
          // Positioned Google sign-in button
          Positioned(
            left: 29,
            right: 29,
            bottom: buttonBottomOffset,
            child: ElevatedButton.icon(
              icon: SvgPicture.asset(
                'assets/icons/google_icon.svg', // Make sure this is the correct path to your SVG
                width: 24,
                height: 24,
              ),
              label: const Text(
                'Continue with Google',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: AppColors.accentGreen,
                onPrimary: Colors.black.withOpacity(0.5),
                minimumSize: const Size(312, 35), // Adjust the size of the button as needed
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Navigate to FirstScreen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstScreen()),
                );
              },
            ),
          ),
          // Positioned logo now moved to be the last element, ensuring it's on top
          Positioned(
            bottom: logoBottomOffset,
            left: logoHorizontalOffset,
            child: Image.asset(
              'assets/images/Logo.png', // Make sure this is the correct path to your image
              width: 157,
              height: 54,
            ),
          ),
        ],
      ),
    );
  }
}
