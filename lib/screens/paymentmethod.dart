import 'dart:convert';
import 'package:aloria/screens/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:aloria/screens/utils/global_user.dart'; // Make sure to import GlobalUser to access user ID

class PaymentMethodScreen extends StatefulWidget {
  final double total;
  final Address selectedAddress;

  const PaymentMethodScreen({super.key, required this.total, required this.selectedAddress});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = 'PayPal';
  bool isLoading = false;

  Future<void> _submitOrder() async {
    setState(() {
      isLoading = true;
    });

    final orderData = {
      'user_id': GlobalUser.userId,
      'total_amount': widget.total,
      'address_id': widget.selectedAddress.addressId,
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8001/orders/orders/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(orderData),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully')),
      );
      // Optionally navigate to a different screen or clear the cart
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 0), // Adjust padding as needed
          child: Text('Back', style: TextStyle(color: Colors.black)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'SELECT PAYMENT METHOD',
                    style: TextStyle(
                      fontFamily: 'Bebas Neue',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                paymentOption('Master Card', 'marster.svg', 'MasterCard'),
                paymentOption('Visa Card', 'visa.svg', 'VisaCard'),
                paymentOption('PayPal', 'paypal.svg', 'PayPal'),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name on the card',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        cardDetailsRow(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'SHIPPING INFORMATION',
                    style: TextStyle(
                      fontFamily: 'Bebas Neue',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                addressDetails(widget.selectedAddress),
                const Divider(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('\$${widget.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitOrder,
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF77BF43),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF403D3D),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              'Pay',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF403D3D),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardDetailsRow() {
    return Row(
      children: [
        const Text(
          '***** 8979',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 10),
        SvgPicture.asset('assets/icons/marster.svg', width: 24),
        const Expanded(
          child: Text(
            '07/27',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget addressDetails(Address address) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.addressLine1,
            style: const TextStyle(color: Colors.black54, fontSize: 18),
          ),
          Text(
            address.addressLine2,
            style: const TextStyle(color: Colors.black54, fontSize: 18),
          ),
          Text(
            '${address.city}, ${address.state}, ${address.postalCode}, ${address.country}',
            style: const TextStyle(color: Colors.black54, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget paymentOption(String title, String iconPath, String methodValue) {
    return ListTile(
      leading: SvgPicture.asset('assets/icons/$iconPath'),
      title: Text(title),
      trailing: Radio<String>(
        value: methodValue,
        groupValue: selectedMethod,
        onChanged: (String? value) {
          setState(() {
            selectedMethod = value!;
          });
        },
        activeColor: const Color(0xFF77BF43),
      ),
    );
  }
}
