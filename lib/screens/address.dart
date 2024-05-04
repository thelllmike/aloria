import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final List<Map<String, dynamic>> addresses = [
    {
      'name': 'Anna Holt',
      'phone': '+94 12345678',
      'address': '1234 Main Street, Anytown, USA',
      'type': 'Home',
      'default': true,
    },
    {
      'name': 'Anna Holt',
      'phone': '+94 12345678',
      'address': '1234 Maple Avenue, Suite 567, City Town, ST 12345, USA',
      'type': 'Office',
      'default': false,
    },
  ];
  double total = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(UniconsLine.angle_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Back', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'SELECT DELIVERY DETAILS',
              style: TextStyle(
                fontFamily: 'Bebas Neue',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Add new address action
              },
              icon: Icon(UniconsLine.plus_circle, color: Colors.white),
              label: Text('Add New Address'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF77BF43),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                var address = addresses[index];
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Checkbox(
                      value: address['default'],
                      onChanged: (bool? newValue) {
                        setState(() {
                          // Set all addresses to not default
                          addresses.forEach((address) => address['default'] = false);
                          // Set the selected one as default
                          addresses[index]['default'] = true;
                        });
                      },
                      activeColor: Color(0xFF77BF43),
                      checkColor: Colors.white,
                    ),
                    title: Text(address['name'] + ' (${address['type']})', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(address['phone'] + '\n' + address['address']),
                    trailing: IconButton(
                      icon: Icon(UniconsLine.edit, color: Colors.grey),
                      onPressed: () {
                        // Edit address action
                      },
                    ),
                    onTap: () {
                      // Optionally set this address as the default one
                    },
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Proceed to payment action
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF77BF43),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(vertical: 12),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Proceed to Payment | \$${total}'),
            ),
          ),
        ],
      ),
    );
  }
}
