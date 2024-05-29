import 'package:aloria/screens/chat.dart';
import 'package:aloria/screens/chatlist.dart';
import 'package:aloria/screens/savedscan.dart';
import 'package:aloria/screens/skintype/CombinationSkin.dart';
import 'package:aloria/screens/skintype/OilySkin.dart';
import 'package:aloria/screens/skintype/dry.dart';
import 'package:flutter/material.dart';

import 'package:aloria/screens/cart.dart';
import 'package:aloria/screens/firstscreen.dart';
import 'package:aloria/screens/google.dart';
import 'package:aloria/screens/instruction/step.dart';
import 'package:aloria/screens/paymentmethod.dart';

import 'package:aloria/screens/shop.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aloria',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SelfieScreen(),  // Set the SelfieScreen as the home screen  ChatScreen  SelfieScreen
      debugShowCheckedModeBanner: false,
      routes: {
        // 'ProductDetailsScreen': (context) => ProductDetailsScreen(),
        // 'AddressScreen': (context) => AddressScreen(),
        'CartScreen': (context) => const CartScreen(),
        'SavedScreen': (context) => const SavedScreen(),
        'ShopScreen': (context) => const ShopScreen(),
        'FirstScreen': (context) => const FirstScreen(),
     
      },
    );
  }
}
