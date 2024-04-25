import 'package:aloria/theme/app_colors.dart';
import 'package:aloria/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
// Adjust the path according to your project structure

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _selectedIndex = 0; // Active index for bottom navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(UniconsLine.paragraph, color: AppColors.appBarIconColor),
        title: const Text('Hi, Anna', style: TextStyle(color: AppColors.appBarTitleColor)),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(UniconsLine.comments, color: AppColors.appBarIconColor),
            onPressed: () {
              // Actions to perform on pressing this button
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 2,
              color: AppColors.itemColor,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'RECENT TESTS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Bebas Neue',
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                  ),
                ),
              ),
            ),
         ListView.separated(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: 4,
  itemBuilder: (BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.itemColor,
        borderRadius: BorderRadius.circular(45.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 36.0, vertical: 4.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),  // Reduced horizontal padding
        leading: const CircleAvatar(
          radius: 44,
          backgroundImage: AssetImage('assets/images/pro.png'),
        ),
        title: const Text(
          'Oily skin',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          'Fair tone',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 20.0,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        trailing: Icon(UniconsLine.angle_right_b, color: Colors.white , size: 52.0,),
      ),
    );
  },
  separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
),

            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'SKIN TYPES',
                  style: TextStyle(
                    fontFamily: 'Bebas Neue',
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSkinTypeIcon(context, 'Dry skin', 'assets/images/dry_skin.png'),
                _buildSkinTypeIcon(context, 'Oily skin', 'assets/images/oily_skin.png'),
                _buildSkinTypeIcon(context, 'Comb. skin', 'assets/images/combination_skin.png'),
                _buildSkinTypeIcon(context, 'Normal skin', 'assets/images/normal_skin.png'),
              ],
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

  Widget _buildSkinTypeIcon(BuildContext context, String label, String iconPath) {
    return Column(
      children: [
        Image.asset(iconPath, width: 52, height: 52),
        SizedBox(height: 8),
        Text(label, style: const TextStyle(fontFamily: 'Nunito', fontSize: 15.0)),
      ],
    );
  }
}
