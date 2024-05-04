import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = 'PayPal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
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
                SizedBox(height: 20),
                const Center(
                  child: Text(
                    'SELECT PAYMENT METHOD',
                    style: TextStyle(
                      fontFamily: 'Bebas Neue',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                paymentOption('Master Card', 'marster.svg', 'MasterCard'),
                paymentOption('Visa Card', 'visa.svg', 'VisaCard'),
                paymentOption('PayPal', 'paypal.svg', 'PayPal'),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(8.0),
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
                        SizedBox(height: 8),
                        cardDetailsRow(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                const Center(
                  child: Text(
                    'SHIPPING INFORMATION',
                    style: TextStyle(
                      fontFamily: 'Bebas Neue',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                addressDetails(),
                Divider(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('\$70.00', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF77BF43),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text('Pay'),
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
        SizedBox(width: 10),
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

  Widget addressDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Anna Holt',
            style: TextStyle(color: Colors.black54, fontSize: 18),
          ),
          Text(
            '1234 Main Street',
            style: TextStyle(color: Colors.black54, fontSize: 18),
          ),
          Text(
            'Anytown, USA',
            style: TextStyle(color: Colors.black54, fontSize: 18),
          ),
          Text(
            '+94 12345678',
            style: TextStyle(color: Colors.black54, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget paymentOption(String title, String iconPath, String methodValue) {
    return ListTile(
      leading: SvgPicture.asset('assets/icons/$iconPath'),
      title: Text(title),
      trailing: Switch(
        value: selectedMethod == methodValue,
        onChanged: (bool value) {
          setState(() {
            selectedMethod = methodValue;
          });
        },
        activeColor: Color(0xFF77BF43),
      ),
    );
  }
}
