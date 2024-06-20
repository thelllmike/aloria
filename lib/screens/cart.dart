import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:aloria/widgets/bottom_nav.dart'; // Assuming you have this custom widget.
import 'package:aloria/theme/app_colors.dart'; // Assuming you have this custom widget.
import 'package:aloria/widgets/menu.dart'; // Assuming you have the custom drawer widget.

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(), // Adding the drawer here
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            _buildSliverAppBar(context),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'CART',
                  style: TextStyle(
                    fontFamily: 'Bebas Neue',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = cartProducts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (bool? value) {},
                          activeColor: const Color(0xFF77BF43),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
                                        image: DecorationImage(
                                          image: AssetImage(product['imageAssetPath']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                product['name'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(UniconsLine.times),
                                                onPressed: () {
                                                  setState(() {
                                                    cartProducts.removeAt(index);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "\$${product['price']}",
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 24,
                                                height: 24,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF77BF43),
                                                  shape: BoxShape.circle,
                                                ),
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(UniconsLine.minus, color: Color(0xFF403D3D)),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (product['quantity'] > 1) {
                                                        product['quantity']--;
                                                      }
                                                    });
                                                  },
                                                  iconSize: 16,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                                child: Text(
                                                  '${product['quantity']}',
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                width: 24,
                                                height: 24,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF77BF43),
                                                  shape: BoxShape.circle,
                                                ),
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(UniconsLine.plus, color: Color(0xFF403D3D)),
                                                  onPressed: () {
                                                    setState(() {
                                                      product['quantity']++;
                                                    });
                                                  },
                                                  iconSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: cartProducts.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      margin: const EdgeInsets.only(top: 20), // Gives space between cart items and promo code
                      decoration: BoxDecoration(
                        color: const Color(0xFF403D3D26), // Dark grey text box color
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Promo Code',
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Logic to apply promo code
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF77BF43), // Green button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              minimumSize: const Size(0, 30), // Remove minimum constraints
                            ),
                            child: const Text(
                              'Apply',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    _buildPriceRow('Total', total),
                    const Divider(),
                    _buildPriceRow('Shipping', shippingFee),
                    const Divider(),
                    _buildPriceRow('Sub Total', total + shippingFee),
                    const SizedBox(height: 20),
                    _buildCheckoutButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
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

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      leading: IconButton(
        icon: Icon(UniconsLine.paragraph, color: Colors.black),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),  // This opens the drawer
      ),
      title: const Text(
        'Hi, Anna',
        style: TextStyle(
          fontFamily: 'Nunito',
          color: Colors.black,
          fontSize: 14.0,
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48.0), // Height for the search area
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding for the AppBar's bottom area
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the leading and trailing icons
            children: [
              const Icon(UniconsLine.filter, size: 20.0, color: Colors.grey), // Filter icon on the left
              Row(
                // Search area on the right
                mainAxisSize: MainAxisSize.min, // Takes the size of its children
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding inside the container for 'Oily skin' text
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Soft grey color for 'Oily skin' text background
                      borderRadius: BorderRadius.circular(24.0), // Rounded corners for the container
                    ),
                    child: const Text(
                      'Oily skin',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.black45,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0), // Space between 'Oily skin' text and search icon
                  const Icon(UniconsLine.search, size: 20.0, color: Colors.grey), // Search icon
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label',
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: const TextStyle(
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
          primary: const Color(0xFF77BF43), // Button color
        ),
        onPressed: () {
          // Proceed to checkout
        },
        child: const Padding(
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
