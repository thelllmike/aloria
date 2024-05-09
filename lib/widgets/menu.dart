import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Anna Holt"),
            accountEmail: Text("annaholt888@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("https://via.placeholder.com/150"),  // Replace with actual image URL
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
              // Navigate or perform actions
            },
          ),
          ListTile(
            leading: Icon(UniconsLine.signout),
            title: const Text('Log out'),
            onTap: () {
              // Navigate or perform actions
            },
          ),
        ],
      ),
    );
  }
}
