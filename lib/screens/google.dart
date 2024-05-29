import 'dart:convert';
import 'package:http/http.dart' as http; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aloria/screens/firstscreen.dart';
import 'package:aloria/theme/app_colors.dart';

class GoogleScreen extends StatelessWidget {
  const GoogleScreen({super.key});

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      print('Starting Google sign-in process');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print('Google sign-in aborted by user');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign in aborted by user')),
        );
        return; // User canceled the sign-in
      }

      print('Google sign-in successful, retrieving authentication');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('Signing in with Firebase credentials');
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        print('Firebase sign-in successful, user: ${user.email}');
        String email = user.email ?? '';

        // Send the email to your FastAPI backend
        print('Sending email to backend');
        final response = await http.post(
          Uri.parse('http://172.20.10.3:8001/users/save_email'), // Replace with your local network IP and port
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email}),
        );

        if (response.statusCode == 200) {
          print('Email successfully saved, navigating to FirstScreen');
          // Navigate to FirstScreen if the email is successfully saved
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FirstScreen()),
          );
        } else {
          print('Failed to save email: ${response.body}');
          // Handle error response
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save email: ${response.body}')),
          );
        }
      } else {
        print('No user returned from Firebase sign-in');
      }
    } catch (e) {
      print('Error during Google sign-in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double logoBottomOffset = screenSize.height * 0.15;
    double logoHorizontalOffset = (screenSize.width - 167) / 2;
    double buttonBottomOffset = screenSize.height * 0.04;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/images/googlegirl.png',
              width: screenSize.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: screenSize.width,
              height: screenSize.height * 0.8,
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
          Positioned(
            left: 29,
            right: 29,
            bottom: buttonBottomOffset,
            child: ElevatedButton.icon(
              icon: SvgPicture.asset(
                'assets/icons/google_icon.svg',
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
                minimumSize: const Size(312, 35),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _signInWithGoogle(context),
            ),
          ),
          Positioned(
            bottom: logoBottomOffset,
            left: logoHorizontalOffset,
            child: Image.asset(
              'assets/images/Logo.png',
              width: 157,
              height: 54,
            ),
          ),
        ],
      ),
    );
  }
}
