import 'dart:convert';
import 'package:aloria/models/Productmodel.dart';
import 'package:aloria/screens/address.dart';
import 'package:aloria/screens/chat.dart';
import 'package:aloria/screens/utils/api_service.dart'; // Import the ApiService
import 'package:aloria/screens/utils/global_user.dart';
import 'package:aloria/theme/app_colors.dart'; // Assuming you have this custom widget.
import 'package:aloria/widgets/bottom_nav.dart'; // Assuming you have this custom widget.
import 'package:aloria/widgets/menu.dart'; // Assuming you have the custom drawer widget.
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:aloria/models/Cartmodel.dart'; // Assuming you have this model for cart items.

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CartItem> cartProducts = [];
  bool isLoading = true;
  Map<int, Product> productsMap = {};

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      List<CartItem> items = await ApiService.getCartItems(GlobalUser.userId!);
      await fetchProductDetails();
      setState(() {
        cartProducts = items;
        isLoading = false;
      });
    } catch (e) {
      print('Failed to fetch cart items: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchProductDetails() async {
    try {
      final response = await ApiService.getProducts();
      if (response.statusCode == 200) {
        List<dynamic> productJson = jsonDecode(response.body);
        for (var productData in productJson) {
          Product product = Product.fromJson(productData);
          productsMap[product.id] = product;
        }
      } else {
        print('Failed to load products');
      }
    } catch (e) {
      print('Failed to fetch product details: $e');
    }
  }

  int _selectedIndex = 0; // Default index if nothing is selected
  double get total => cartProducts.fold(0, (sum, item) => sum + item.quantity * (productsMap[item.productId]?.price ?? 0.0));
  final double shippingFee = 10.0;

  @override
  Widget build(BuildContext context) {
    // Extract the first name from GlobalUser.name
    String firstName = (GlobalUser.name != null && GlobalUser.name!.isNotEmpty)
        ? GlobalUser.name!.split(' ')[0]
        : "Anna";

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(), // Adding the drawer here
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildAppBar(context, firstName),
            Container(
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
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : cartProducts.isEmpty
                      ? Center(child: Text('Your cart is empty'))
                      : ListView.builder(
                          itemCount: cartProducts.length,
                          itemBuilder: (context, index) {
                            final cartItem = cartProducts[index];
                            final product = productsMap[cartItem.productId];
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
                                                    image: NetworkImage(product?.imageUrl ?? ''),
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
                                                          product?.name ?? 'Unknown Product',
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
                                                      "\$${product?.price ?? 0.0}",
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
                                                                if (cartItem.quantity > 1) {
                                                                  cartItem.quantity--;
                                                                }
                                                              });
                                                            },
                                                            iconSize: 16,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                                          child: Text(
                                                            '${cartItem.quantity}',
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
                                                                cartItem.quantity++;
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
                        ),
            ),
            Container(
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

  Widget _buildAppBar(BuildContext context, String firstName) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(UniconsLine.paragraph, color: Colors.black),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(), // This opens the drawer
      ),
      title: Text(
        'Hi, $firstName',
        style: const TextStyle(
          fontFamily: 'Nunito',
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(UniconsLine.comments, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()), // Navigate to ChatScreen
            );
          },
        ),
      ],
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
          Navigator.of(context).push(_createRoute());
        },
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Proceed to Checkout',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF403D3D),
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const AddressScreen(),
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
    );
  }
}
