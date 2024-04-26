import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:aloria/theme/app_colors.dart'; // Import AppColors

class TestResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white, // Set the background color to white
              expandedHeight: 250.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/test.png',
                  fit: BoxFit.cover,
                ),
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(UniconsLine.angle_left, color: Colors.black),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Bebas Neue',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(UniconsLine.heart, color: Colors.black),
                  onPressed: () {
                    // Favorite button action
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Text(
                      'TEST RESULTS',
                      style: TextStyle(
                        fontSize: 24.0,
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
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'SUGGESTED PRODUCTS',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...List.generate(2, (index) => _buildProductCard(context)).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget _buildResultIndicator(BuildContext context, String label, double percentage) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.appBarTitleColor, // Use appBarTitleColor for the progress indicator
              ),
              strokeWidth: 5,
            ),
          ),
          Text(
            '${percentage.toInt()}%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.appBarTitleColor, // Use appBarTitleColor for the text
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          fontSize: 16.0,
          color: AppColors.appBarTitleColor, // Use appBarTitleColor for the label
        ),
      ),
    ],
  );
}



Widget _buildProductCard(BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0), // padding top, right, bottom, left
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // stretches the button to the full width
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/product1.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.0, // Position to the top right with some padding
                right: 8.0,
                child: IconButton(
                  icon: const Icon(UniconsLine.heart, color: Colors.grey),
                  onPressed: () {
                    // Favorite button action
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24), // gap between the image and the text
          const Text(
            'The ordinary',
            style: TextStyle(
              fontFamily: 'Bebas Neue',
              fontSize: 18.0,
              color: AppColors.appBarTitleColor,
            ),
          ),
          const Text(
            'Squalene Cleanser',
            style: TextStyle(
              fontFamily: 'Bebas Neue',
              fontSize: 16.0,
              color: AppColors.appBarTitleColor,
            ),
          ),
          const SizedBox(height: 4), // gap between title and price
          Text(
            '\$20',
            style: TextStyle(
              fontFamily: 'Bebas Neue',
              fontSize: 18.0,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8), // gap between price and button
          ElevatedButton.icon(
            onPressed: () {
              // Add to cart action
            },
            icon: Icon(UniconsLine.shopping_basket),
            label: const Text(
              'Add to cart',
              style: TextStyle(
                fontFamily: 'Bebas Neue',
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: AppColors.accentGreen, // Use accentGreen for the button color
              onPrimary: Colors.white, // Text color
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0)),
              ),
              textStyle: const TextStyle(
                fontFamily: 'Bebas Neue',
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


}
