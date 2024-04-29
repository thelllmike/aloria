import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:aloria/widgets/bottom_nav.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> cartProducts = [
    {
      'imageAssetPath': 'assets/images/cart.png',
      'name': 'Gommage Scrub',
      'quantity': 1,
      'price': 30.0,
    },
    // Add more cart item as per your data
  ];

 int _selectedIndex = 0; // Default index if nothing is selected

  double get total => cartProducts.fold(0, (sum, item) => sum + item['quantity'] * item['price']);
  final double shippingFee = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar settings
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProducts.length,
              itemBuilder: (BuildContext context, int index) {
                final product = cartProducts[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(product['imageAssetPath']),
                    title: Text(
                      product['name'],
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Text(
                      'YES',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.grey,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(UniconsLine.minus_square, color: Color(0xFF77BF43)),
                          onPressed: () {
                            setState(() {
                              if (product['quantity'] > 1) {
                                product['quantity']--;
                              }
                            });
                          },
                        ),
                        Text(
                          '${product['quantity']}',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16.0,
                          ),
                        ),
                        IconButton(
                          icon: Icon(UniconsLine.plus_square, color: Color(0xFF77BF43)),
                          onPressed: () {
                            setState(() {
                              product['quantity']++;
                            });
                          },
                        ),
                      ],
                    ),
                    onLongPress: () {
                      // Add functionality to remove or edit items
                    },
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  '\$${shippingFee.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub Total',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  '\$${(total + shippingFee).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF77BF43), // Button color
                ),
                onPressed: () {
                  // Proceed to checkout
                },
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
       bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
