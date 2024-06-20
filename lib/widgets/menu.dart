import 'package:aloria/screens/google.dart';
import 'package:aloria/screens/utils/global_user.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:aloria/screens/chat.dart'; // Import ChatScreen


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    // Clear user information from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Clear global user information
    GlobalUser.name = null;
    GlobalUser.email = null;
    GlobalUser.profilePictureUrl = null;

    // Navigate to GoogleScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => GoogleScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(GlobalUser.name ?? "Anna Holt"),
            accountEmail: Text(GlobalUser.email ?? "annaholt888@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(GlobalUser.profilePictureUrl ?? "https://via.placeholder.com/150"),  // Replace with actual image URL
            ),
          ),
          ListTile(
            leading: Icon(UniconsLine.prescription_bottle),
            title: Text('Ingredients'),
            onTap: () {
              // Navigate or perform actions
            },
          ),
          ListTile(
            leading: Icon(UniconsLine.question_circle),
            title: Text('FAQ'),
            onTap: () {
              // Navigate or perform actions
            },
          ),
          ListTile(
            leading: Icon(UniconsLine.chat_info),
            title: Text('Chat with us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),  // Navigate to ChatScreen
              );
            },
          ),
          ListTile(
            leading: const Icon(UniconsLine.signout),
            title: const Text('Log out'),
            onTap: () => _signOut(context),
          ),
        ],
      ),
    );
  }
}
