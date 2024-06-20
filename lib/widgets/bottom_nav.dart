import 'package:aloria/screens/cart.dart';
import 'package:aloria/screens/firstscreen.dart';
import 'package:aloria/screens/savedscan.dart';
import 'package:aloria/screens/shop.dart';
import 'package:aloria/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottomNavItem(context, UniconsLine.home_alt, 'Home', 0, smallerIcon: true, navigateTo: 'FirstScreen'),
            _buildBottomNavItem(context, UniconsLine.store, 'Store', 1, smallerIcon: true, navigateTo: 'ShopScreen'),
            _buildBottomNavItem(context, Icons.camera, '', 2, isSVG: true, isCameraIcon: true),  // Camera icon
            _buildBottomNavItem(context, UniconsLine.heart, 'Saved', 3, smallerIcon: true, navigateTo: 'SavedScreen'),
            _buildBottomNavItem(context, UniconsLine.shopping_basket, 'Cart', 4, smallerIcon: true, navigateTo: 'CartScreen'),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(BuildContext context, IconData icon, String label, int index, {bool isSVG = false, bool isCameraIcon = false, bool smallerIcon = false, String? navigateTo}) {
    bool isSelected = selectedIndex == index;
    Color iconColor = isSelected ? AppColors.itemColor : Colors.grey;
    if (isCameraIcon) {
      iconColor = const Color(0xFF77BF43);  // Specific color for camera icon
    }

    TextStyle labelStyle = TextStyle(
      color: isSelected ? AppColors.itemColor : Colors.grey,
      fontSize: 12,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
    );

    Widget iconWidget;
    if (isSVG && isCameraIcon) {
      iconWidget = SvgPicture.asset(
        'assets/icons/shutter.svg',
        color: iconColor,
        width: 50,  // Larger size for camera icon
        height: 50,
      );
    } else {
      double iconSize = smallerIcon ? 24 : 30;  // Smaller size for other icons
      iconWidget = Icon(icon, color: iconColor, size: iconSize);
    }

    List<Widget> columnChildren = [iconWidget];
    if (label.isNotEmpty) {
      columnChildren.add(Text(label, style: labelStyle));
    }

    return InkWell(
      onTap: () {
        if (navigateTo != null) {
          _navigateTo(context, navigateTo);
        } else {
          onItemSelected(index);
        }
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: columnChildren,
      ),
    );
  }

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => _getPage(routeName),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);  // Slide from the right
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
      (Route<dynamic> route) => false, // Remove all previous routes
    );
  }

  Widget _getPage(String routeName) {
    switch (routeName) {
      case 'FirstScreen':
        return FirstScreen();
      case 'ShopScreen':
        return ShopScreen();
      case 'SavedScreen':
        return SavedScreen();
      case 'CartScreen':
        return CartScreen();
      default:
        return FirstScreen();  // Default to FirstScreen if route is not found
    }
  }
}
