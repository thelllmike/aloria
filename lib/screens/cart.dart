import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:aloria/widgets/bottom_nav.dart';  // Assuming you have this custom widget.

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

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
    {
      'imageAssetPath': 'assets/images/cart.png',
      'name': 'Gommage Scrub',
      'quantity': 2,
      'price': 30.0,
    },
  ];

  int _selectedIndex = 0; // Default index if nothing is selected
  double get total => cartProducts.fold(0, (sum, item) => sum + item['quantity'] * item['price']);
  final double shippingFee = 10.0;

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      leading: IconButton(
        icon: const Icon(UniconsLine.paragraph, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: const Text(
        'Hi, Anna',
        style: TextStyle(
          fontFamily: 'Nunito',
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(UniconsLine.comments, color: Colors.black),
          onPressed: () {
            // Search button action
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: true,
                  leading: IconButton(
                    icon: const Icon(UniconsLine.paragraph, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: const Text(
                    'Hi, Anna',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(UniconsLine.comments, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = cartProducts[index];
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 35),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: true,
                                    onChanged: (bool? value) {},
                                    activeColor: Color(0xFF77BF43),
                                  ),
                                  SizedBox(width: 10),
                                  Image.asset(
                                    product['imageAssetPath'],
                                    width: 60,
                                    height: 60,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['name'],
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "\$${product['price']}",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            color: Color(0xFF77BF43),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                icon: Icon(UniconsLine.times, color: Color(0xFF403D3D)),
                                onPressed: () {
                                  setState(() {
                                    cartProducts.removeAt(index);
                                  });
                                },
                              ),
                            ),
                           Positioned(
  bottom: 8,  // Adjust this value to position the row lower or higher
  right: 10,  // Adjust this value to align the row to the right as needed
  child: Row(
    children: [
      Container(
        width: 28,  // Specify width for a smaller circle
        height: 28,  // Specify height for a smaller circle
        decoration: BoxDecoration(
          color: Color(0xFF77BF43),  // Green color background
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(UniconsLine.minus, color: Colors.white),
          onPressed: () {
            setState(() {
              if (product['quantity'] > 1) {
                product['quantity']--;
              }
            });
          },
          iconSize: 16,  // Smaller icon size
          padding: EdgeInsets.all(0),  // Minimal padding to reduce overall size
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          '${product['quantity']}',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ),
      Container(
        width: 28,  // Specify width for a smaller circle
        height: 28,  // Specify height for a smaller circle
        decoration: BoxDecoration(
          color: Color(0xFF77BF43),  // Green color background
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(UniconsLine.plus, color: Colors.white),
          onPressed: () {
            setState(() {
              product['quantity']++;
            });
          },
          iconSize: 16,  // Smaller icon size
          padding: EdgeInsets.all(0),  // Minimal padding to reduce overall size
        ),
      ),
    ],
  ),
)

                          ],
                        ),
                      );
                    },
                    childCount: cartProducts.length,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Divider(),
                _buildPriceRow('Total', total),
                _buildPriceRow('Shipping', shippingFee),
                Divider(),
                _buildPriceRow('Sub Total', total + shippingFee),
                SizedBox(height: 20),
                _buildCheckoutButton(),
              ],
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



  Widget _buildPriceRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
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
    );
  }
}
