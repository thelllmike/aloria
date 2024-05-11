import 'package:flutter/material.dart';
import 'package:aloria/widgets/bottom_nav.dart'; // Ensure this is the correct path to your custom navigation bar widget

class DermatologistScreen extends StatefulWidget {
  const DermatologistScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DermatologistScreenState createState() => _DermatologistScreenState();
}

class _DermatologistScreenState extends State<DermatologistScreen> {
  int _selectedIndex = 1;  // Assuming '1' corresponds to the 'Store' where this screen is relevant

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Additional navigation logic can be added here if necessary
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: const Text('Back', style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Center(
  child: Padding(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: Text(
      'CURRENTLY AVAILABLE \nDERMATOLOGISTS',
      textAlign: TextAlign.center, // Ensures text is centered within its container
      style: TextStyle(
        fontFamily: 'Bebas Neue',
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

            ...List.generate(3, (index) => const ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/demologist.png'),
              ),
              title: Text('Dr. Lia Halpert'),
              subtitle: Text('Active 36 min ago', style: TextStyle(color: Colors.grey)),
              trailing: Icon(Icons.circle, color: Colors.green, size: 12),
            )),
          const Padding(
  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),  // Increased left padding to 40.0
  child: Text(
    'Recent messages',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  ),
),

            ...List.generate(5, (index) => const ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/demologist.png'),
              ),
              title: Text('Dr. Lia Halpert'),
              subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit...', style: TextStyle(color: Colors.grey)),
              trailing: Text('4.15 PM'),
            )),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
