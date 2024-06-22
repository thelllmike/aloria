import 'dart:convert';
import 'package:aloria/screens/utils/global_user.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aloria/screens/firstscreen.dart';
import 'package:aloria/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        GlobalUser.name = user.displayName;
        GlobalUser.email = user.email;
        GlobalUser.profilePictureUrl = user.photoURL;

        // Save user information to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', GlobalUser.name ?? '');
        await prefs.setString('email', GlobalUser.email ?? '');
        await prefs.setString('profilePictureUrl', GlobalUser.profilePictureUrl ?? '');

        String email = user.email ?? '';

        print('Sending email to backend');
        final response = await http.post(
          Uri.parse('http://10.0.2.2:8001/users/save_email/?email=$email'), // Use 10.0.2.2 for emulator
          headers: {'accept': 'application/json'},
        );

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          if (responseBody['message'] == 'Email saved successfully' || responseBody['message'] == 'Email already registered') {
            print('Email successfully saved, retrieving userId');
            GlobalUser.userId = responseBody['user_id']; // Save user ID globally
            print('User ID: ${GlobalUser.userId}');
            if (context.mounted) {
              _navigateToFirstScreen(context);
            }
          } else {
            print('Failed to save email: ${responseBody['message']}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseBody['message'])),
            );
          }
        } else {
          print('Failed to save email: ${response.body}');
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

  void _navigateToFirstScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const FirstScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Change these values to adjust the transition
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
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
