import 'package:aloria/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';


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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildBottomNavItem(UniconsLine.home_alt, 'Home', 0),
          _buildBottomNavItem(UniconsLine.store, 'Store', 1),
          _buildBottomNavItem(UniconsLine.heart, 'Saved', 2),
          _buildBottomNavItem(UniconsLine.shopping_basket, 'Cart', 3),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
     const itemColor = Color(0xFF403D3D);
    return InkResponse(
      onTap: () => onItemSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 40,
        height: 40,
        decoration: selectedIndex == index
            ? BoxDecoration(
                    color: AppColors.itemColor, // Using color from AppColors
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(
          icon,
          color: selectedIndex == index ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
