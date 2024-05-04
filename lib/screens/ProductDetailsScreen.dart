import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Back', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          )
        ],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/productscreen.png', fit: BoxFit.cover),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'Gommage Scrub',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 4),
    Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'YVES',
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    ),
    SizedBox(height: 8),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$30',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF77BF43)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset('assets/images/dry_skin.png', height: 60),
            ),
            SizedBox(height: 8),
            Text('Dry skin', style: TextStyle(fontSize: 16)),
          ],
        ),
      ],
    ),
    SizedBox(height: 16),
    Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      style: TextStyle(fontSize: 16),
    ),
    TextButton(
      onPressed: () {},
      child: Text('View More', style: TextStyle(color: Color(0xFF77BF43))),
    ),
    SizedBox(height: 8),
    Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove, color: Color(0xFF77BF43)),
          onPressed: () {},
        ),
        Text('1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        IconButton(
          icon: Icon(Icons.add, color: Color(0xFF77BF43)),
          onPressed: () {},
        ),
        Spacer(),
        Text('999 in stock', style: TextStyle(color: Colors.grey)),
      ],
    ),
  ],
),

                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF77BF43), // background (button) color
                onPrimary: Colors.white, // foreground (text) color
                minimumSize: Size(double.infinity, 50), // button size
              ),
              child: Text(
                'Buy Now',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
       Container(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // corrected line
  child: Text(
    '1 item(s) selected \$30.00',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.white, fontSize: 16, backgroundColor: Color(0xFF77BF43)),
  ),
),

        ],
      ),
    );
  }
}
