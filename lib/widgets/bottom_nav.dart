import 'package:aloria/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_svg/flutter_svg.dart';  // Import flutter_svg

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
            _buildBottomNavItem(UniconsLine.home_alt, 'Home', 0, smallerIcon: true),
            _buildBottomNavItem(UniconsLine.store, 'Store', 1, smallerIcon: true),
            _buildBottomNavItem(Icons.camera, '', 2, isSVG: true, isCameraIcon: true),  // Camera icon
            _buildBottomNavItem(UniconsLine.heart, 'Saved', 3, smallerIcon: true),
            _buildBottomNavItem(UniconsLine.shopping_basket, 'Cart', 4, smallerIcon: true),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index, {bool isSVG = false, bool isCameraIcon = false, bool smallerIcon = false}) {
    bool isSelected = selectedIndex == index;
    Color iconColor = isSelected ? AppColors.itemColor : Colors.grey;
    if (isCameraIcon) {
      iconColor = Color(0xFF77BF43);  // Specific color for camera icon
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
        height: 50
      );
    } else {
      // Smaller size for non-camera icons if smallerIcon is true
      double iconSize = smallerIcon ? 24 : 30;  // Smaller size for other icons
      iconWidget = Icon(icon, color: iconColor, size: iconSize);
    }

    List<Widget> columnChildren = [iconWidget];
    if (label.isNotEmpty) {  // Only add the label text if it is not empty
      columnChildren.add(Text(label, style: labelStyle));
    }

    return InkWell(
      onTap: () => onItemSelected(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center, // Center icon when no text is present
        children: columnChildren,
      ),
    );
  }
}
