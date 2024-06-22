import 'dart:convert';
import 'package:aloria/screens/AddAddressScreen.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:http/http.dart' as http;
import 'package:aloria/screens/utils/global_user.dart';

class Address {
  final int userId;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final int addressId;
  final String createdAt;

  Address({
    required this.userId,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.addressId,
    required this.createdAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      userId: json['user_id'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      country: json['country'],
      addressId: json['address_id'],
      createdAt: json['created_at'],
    );
  }
}

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<Address> addresses = [];
  bool isLoading = true;
  double total = 70;

  @override
  void initState() {
    super.initState();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8001/addresses/addresses/${GlobalUser.userId}'),
    );

    if (response.statusCode == 200) {
      List<dynamic> addressJson = jsonDecode(response.body);
      setState(() {
        addresses = addressJson.map((json) => Address.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load addresses');
    }
  }

  void _navigateToAddAddressScreen() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const AddAddressScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ).then((value) {
      if (value == true) {
        fetchAddresses(); // Refresh addresses after adding a new one
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(UniconsLine.angle_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Back', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'SELECT DELIVERY DETAILS',
              style: TextStyle(
                fontFamily: 'Bebas Neue',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: _navigateToAddAddressScreen,
              icon: const Icon(UniconsLine.plus_circle, color: Color(0xFF403D3D)),
              label: const Text(
                'Add New Address',
                style: TextStyle(
                  color: Color(0xFF403D3D),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF77BF43),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      var address = addresses[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: Checkbox(
                            value: address.addressId == addresses.first.addressId,
                            onChanged: (bool? newValue) {
                              setState(() {
                                // Set all addresses to not default
                                addresses.forEach((address) {
                                  address.addressId == address.addressId;
                                });
                                // Set the selected one as default
                                addresses[index].addressId;
                              });
                            },
                            activeColor: const Color(0xFF77BF43),
                            checkColor: Colors.white,
                          ),
                          title: Text(
                            address.addressLine1,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${address.city}, ${address.state}, ${address.country}'),
                          trailing: IconButton(
                            icon: const Icon(UniconsLine.edit, color: Colors.grey),
                            onPressed: () {
                              // Edit address action
                            },
                          ),
                          onTap: () {
                            // Optionally set this address as the default one
                          },
                          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Proceed to payment action
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF77BF43),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                'Proceed to Payment | \$${total}',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF403D3D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
