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
    margin: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12.0), bottom: Radius.circular(10)),
    ),
    elevation: 5.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0), bottom: Radius.circular(0)),
              child: Image.asset(
                'assets/images/product1.png',
                width: double.infinity,
                height: 120.0,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: Icon(
                UniconsLine.heart,
                color: const Color.fromARGB(255, 54, 53, 53),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // Ensures alignment starts from the same point
            children: [
              const Text(
                'The ordinary',
                style: TextStyle(
                  fontFamily: 'Bebas Neue',
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Squalene Cleanser',
                    style: TextStyle(
                      fontFamily: 'Bebas Neue',
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '\$20',
                    style: TextStyle(
                      fontFamily: 'Bebas Neue',
                      fontSize: 16.0,
                      color: AppColors.itemColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(UniconsLine.shopping_basket),
                  label: Text(
                    'Add to cart',
                    style: TextStyle(
                      fontFamily: 'Bebas Neue',
                      fontSize: 16.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    minimumSize: Size(80, 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
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
