import 'package:aloria/screens/chat.dart';
import 'package:aloria/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:aloria/theme/app_colors.dart'; // Ensure this file has the required color definitions.
import 'package:aloria/widgets/bottom_nav.dart';
import 'package:aloria/widgets/app_bar.dart'; 

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShopScreenState createState() => _ShopScreenState();
  
}

class _ShopScreenState extends State<ShopScreen> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); 
  final List<Map<String, String>> productList = [
    {
      'imageAssetPath': 'assets/images/product1.png',
      'name': 'Squalene Cleanser',
      'price': '\$20'
    },
    {
      'imageAssetPath': 'assets/images/product1.png',
      'name': 'Moisturizing Cream',
      'price': '\$15'
    },
    {
      'imageAssetPath': 'assets/images/product1.png',
      'name': 'Squalene Cleanser',
      'price': '\$20'
    },
    {
      'imageAssetPath': 'assets/images/product1.png',
      'name': 'Moisturizing Cream',
      'price': '\$15'
    },
    {
      'imageAssetPath': 'assets/images/product1.png',
      'name': 'Squalene Cleanser',
      'price': '\$20'
    },
    {
      'imageAssetPath': 'assets/images/product1.png',
      'name': 'Moisturizing Cream',
      'price': '\$15'
    },

    // Add more products as per your data
  ];

  int _selectedIndex = 0; // Default index if nothing is selected

 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),  // Adding the drawer here
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            _buildSliverAppBar(context),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  _buildContent(context),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0,
        onItemSelected: (index) {
          setState(() {
            // Update selected index
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()), // Navigate to ChatScreen
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48.0), // Height for the search area
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal:
                  16.0), // Horizontal padding for the AppBar's bottom area
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Space between the leading and trailing icons
            children: [
              const Icon(UniconsLine.filter,
                  size: 20.0, color: Colors.grey), // Filter icon on the left
              Row(
                // Search area on the right
                mainAxisSize:
                    MainAxisSize.min, // Takes the size of its children
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical:
                            8.0), // Padding inside the container for 'Oily skin' text
                    decoration: BoxDecoration(
                      color: Colors.grey[
                          200], // Soft grey color for 'Oily skin' text background
                      borderRadius: BorderRadius.circular(
                          24.0), // Rounded corners for the container
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
                  const SizedBox(
                      width:
                          8.0), // Space between 'Oily skin' text and search icon
                  const Icon(UniconsLine.search,
                      size: 20.0, color: Colors.grey), // Search icon
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.8,
            ),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final product = productList[index];
              return _buildProductCard(
                context,
                product['imageAssetPath']!,
                product['name']!,
                product['price']!,
              );
            },
          ),
          const SizedBox(height: 20), // Space before the button
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String assetPath,
      String productName, String productPrice) {
    return Card(
      margin: const EdgeInsets.fromLTRB(
          10.0, 10.0, 14.0, 0.0), // Increased bottom margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.asset(
                  assetPath,
                  width: 160.0,
                  height: 110.0,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: AppColors.appBarTitleColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(
                    UniconsLine.heart,
                    color: Colors.white,
                    size: 16.0,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                8.0, 8.0, 8.0, 20.0), // Increased bottom padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontFamily: 'Bebas Neue',
                    fontSize: 10.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontFamily: 'Bebas Neue',
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      productPrice,
                      style: const TextStyle(
                        fontFamily: 'Bebas Neue',
                        fontSize: 12.0,
                        color: AppColors.appBarTitleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Transform.scale(
                      scale: 0.6,
                      child: const Icon(
                        UniconsLine.shopping_basket,
                        color: AppColors.itemColor,
                      ),
                    ),
                    label: const Text(
                      'Add to cart',
                      style: TextStyle(
                        fontFamily: 'Bebas Neue',
                        fontSize: 10.0,
                        color: AppColors.itemColor,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.accentGreen,
                      onPrimary: Colors.white,
                      minimumSize: const Size(80, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
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
}
