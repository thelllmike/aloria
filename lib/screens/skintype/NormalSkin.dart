import 'package:flutter/material.dart';

class NormalSkinScreen extends StatelessWidget {
  const NormalSkinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: const Text('Back', style: TextStyle(color: Colors.black)),
        elevation: 1,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'NORMAL SKIN',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/normal.png', // Replace with your actual asset path
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Your skin is well-balanced, not too oily or too dry. The right skincare products will help maintain your skin’s natural balance and keep it healthy.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF77BF43), // Button background color updated to 0xFF77BF43
                onPrimary: Colors.white, // Button text color
                minimumSize: const Size(double.infinity, 50), // Button size
              ),
              child: const Text('Shall we put it to the test?'),
            ),
          ),
        ],
      ),
    );
  }
}
