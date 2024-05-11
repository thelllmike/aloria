import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:aloria/theme/app_colors.dart'; // Ensure this file has the required color definitions.

class TestResultsScreen extends StatelessWidget {
   TestResultsScreen({super.key});
  // Dummy product data - replace with your actual product data
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

 

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // This SizedBox will create space to ensure the content
                // starts where the image ends. You may remove it
                // or adjust its height as necessary.
                const SizedBox(height: 20.0),
                _buildContent(context),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
        backgroundColor: Colors.white,  // Confirming white background
        expandedHeight: 450.0,
        pinned: true,  // Keeps the AppBar visible
        flexibleSpace: const FlexibleSpaceBar(
            background: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,  // Ensuring white underlay for transparency in image
                image: DecorationImage(
                  image: AssetImage('assets/images/test.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ),
        leading: InkWell(
            onTap: () {
                Navigator.of(context).pop();  // Navigates back on tap
            },
            child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        Icon(UniconsLine.angle_left, color: Colors.black),
                        SizedBox(width: 4.0),
                        Text(
                            'Back',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                color: Colors.black,
                                fontSize: 14.0,
                            ),
                        ),
                    ],
                ),
            ),
        ),
        actions: [
            IconButton(
                icon: const Icon(UniconsLine.heart, color: Colors.black),
                onPressed: () {
                    // Favorite button action
                },
            ),
        ],
    );
}



Widget _buildContent(BuildContext context) {
  // ignore: avoid_unnecessary_containers
  return Container(
  
    child: Column(
      children: [
        const Text(
          
          'TEST RESULTS',
          style: TextStyle(
            fontFamily: 'Bebas Neue',
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildResultIndicator(context, 'Oily', 85),
            _buildResultIndicator(context, 'Comb.', 10),
            _buildResultIndicator(context, 'Normal', 3),
            _buildResultIndicator(context, 'Dry', 2),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Text(
            'SUGGESTED PRODUCTS',
            style: TextStyle(
              fontFamily: 'Bebas Neue',
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
        Container(
  width: 320.0, // Set your desired button width here
  child: ElevatedButton(
    onPressed: () {
      // Handle button press
    },
    style: ElevatedButton.styleFrom(
      primary: AppColors.accentGreen, // Use the accentGreen color defined in AppColors
      onPrimary: AppColors.appBarIconColor, // Use the appBarIconColor for the text color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Padding inside the button
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min, // To make the row only as wide as its children
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Contact a dermatologist ',
          style: TextStyle(
            fontFamily: 'Nunito', // Set the font family to Nunito
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.itemColor, // Use the itemColor for the text color
          ),
        ),
        Icon(
          UniconsLine.comments, // The chat icon (or any other preferred icon)
          color: AppColors.itemColor, // Use the itemColor for the icon color
        ),
      ],
    ),
  ),
),

        const SizedBox(height: 20), // Space after the button
      
    
  
      ],
    ),
  );
}

  Widget _buildResultIndicator(BuildContext context, String label, int percentage) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: percentage / 100.0,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.itemColor),
                strokeWidth: 5,
              ),
            ),
            Text(
              '$percentage%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.itemColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            color: AppColors.appBarIconColor,
          ),
        ),
      ],
    );
  }

Widget _buildProductCard(
    BuildContext context, String assetPath, String productName, String productPrice) {
  return Card(
    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),  // Increased bottom margin
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
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),  // Increased bottom padding
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


