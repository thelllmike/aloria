import 'dart:typed_data';
import 'package:aloria/models/Productmodel.dart';
import 'package:aloria/screens/chat.dart';
import 'package:aloria/screens/utils/api_service.dart';
import 'package:aloria/screens/utils/global_user.dart';
import 'package:aloria/theme/app_colors.dart';
import 'package:aloria/widgets/bottom_nav.dart';
import 'package:aloria/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unicons/unicons.dart';
import 'dart:convert';
import 'package:flutter_image_compress/flutter_image_compress.dart';



class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Define the scaffold key
  int _selectedIndex = 0; // Define the selected index

  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await ApiService.getProducts();

    if (response.statusCode == 200) {
      final List<dynamic> productJson = json.decode(response.body);
      setState(() {
        productList = productJson.map((json) => Product.fromJson(json)).toList();
      });

      // Debugging: Print the product list to verify the image URLs
      for (var product in productList) {
        print('Product: ${product.name}, Image URL: ${product.imageUrl}');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Uint8List?> resizeImage(String url, int width, int height) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final originalImage = response.bodyBytes;
        final compressedImage = await FlutterImageCompress.compressWithList(
          originalImage,
          minWidth: width,
          minHeight: height,
          quality: 85,
        );
        return Uint8List.fromList(compressedImage);
      } else {
        print('Failed to load image from $url, status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error resizing image from $url: $e');
      return null;
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    try {
      final response = await ApiService.addToCart(GlobalUser.userId!, productId, quantity);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added to cart')),
        );
      } else {
        print('Failed to add to cart: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add to cart: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error adding to cart: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding to cart: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Extract the first name from GlobalUser.name
    String firstName = (GlobalUser.name != null && GlobalUser.name!.isNotEmpty)
        ? GlobalUser.name!.split(' ')[0]
        : "Anna";

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            _buildSliverAppBar(context, firstName),
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
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context, String firstName) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      leading: IconButton(
        icon: const Icon(UniconsLine.paragraph, color: Colors.black),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
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
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(UniconsLine.filter, size: 20.0, color: Colors.grey),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24.0),
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
                  const SizedBox(width: 8.0),
                  const Icon(UniconsLine.search, size: 20.0, color: Colors.grey),
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
              // ignore: avoid_print
              print('Loading image for product: ${product.name}, URL: ${product.imageUrl}');
              return FutureBuilder<Uint8List?>(
                future: resizeImage(product.imageUrl, 160, 110),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return _buildProductCard(
                        context,
                        MemoryImage(snapshot.data!),
                        product,
                      );
                    } else if (snapshot.hasError || snapshot.data == null) {
                      print('Error loading image: ${snapshot.error}');
                      return _buildProductCard(
                        context,
                        null,
                        product,
                      );
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ImageProvider? imageProvider, Product product) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 14.0, 0.0),
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
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: imageProvider != null
                    ? Image(
                        image: imageProvider,
                        width: 160.0,
                        height: 110.0,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 160.0,
                        height: 110.0,
                        color: Colors.grey,
                        child: const Icon(Icons.error, color: Colors.red),
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
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontFamily: 'Bebas Neue',
                    fontSize: 10.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.brand,
                      style: const TextStyle(
                        fontFamily: 'Bebas Neue',
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      product.price.toString(),
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
                    onPressed: () {
                      addToCart(product.id, 1); // Add product to cart with quantity 1
                    },
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
