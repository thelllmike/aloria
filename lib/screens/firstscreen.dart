import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unicons/unicons.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _selectedIndex = 0; // Active index for bottom navigation
  

  @override
  Widget build(BuildContext context) {
    const itemColor = Color(0xFF403D3D);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.white),
        title: Text('Hi, Anna', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Search action
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                      const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center( // Center widget added here
               child: Text(
    'RECENT TESTS',
    textAlign: TextAlign.center, // Centers the text horizontally
    style: TextStyle(
      fontFamily: 'Bebas Neue',
      fontSize: 28.0,
      fontWeight: FontWeight.w700, // 700 is equivalent to 'bold'
      height: 1.0, // Normal line spacing for 32px font size
    ),)
              ),
            ),
        ListView.separated(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: 4, // Replace with your dynamic data size
  itemBuilder: (BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: itemColor, // Your specified color for ListTile background.
        borderRadius: BorderRadius.circular(45.0), // More rounded corner.
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0), // Margin for spacing between items.
      child: ListTile(
        leading: CircleAvatar(
          radius: 36.0, // The radius is half the desired width, to get the width of 72px.
          backgroundImage: AssetImage('assets/images/pro.png'), // Your profile image asset.
        ),
        title: Text(
          'Oily skin',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 20.0,
            fontWeight: FontWeight.w700, // Bold font weight as Nunito-Bold.
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          'Fair tone',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 20.0, // Assuming you want the subtitle the same size as title.
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        trailing: Icon(UniconsLine.arrow_right, color: Colors.white),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
      ),
    );
  },
  separatorBuilder: (BuildContext context, int index) {
    return SizedBox(height: 10); // This adds space between the items.
  },
),

            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                'SKIN TYPES',
                 style: TextStyle(
       fontFamily: 'Bebas Neue',
       fontSize: 28.0,
       fontWeight: FontWeight.w700, // 700 is equivalent to 'bold'
       height: 1.0, // Normal line spacing for 32px font size
     ),)
               
              )
              )
              ,
            



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSkinTypeIcon(
                    context, 'Dry skin', 'assets/images/dry_skin.png'),
                _buildSkinTypeIcon(
                    context, 'Oily skin', 'assets/images/oily_skin.png'),
                _buildSkinTypeIcon(context, 'Comb. skin',
                    'assets/images/combination_skin.png'),
                _buildSkinTypeIcon(
                    context, 'Normal skin', 'assets/images/normal_skin.png'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _customBottomNavigationBar(),
    );
  }

  Widget _buildSkinTypeIcon(
      BuildContext context, String label, String iconPath) {
    return Column(
      children: [
        Image.asset(iconPath, width: 40, height: 40),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }

 Widget _customBottomNavigationBar() {
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
    bool isSelected = _selectedIndex == index;
    const itemColor = Color(0xFF403D3D);
    return InkResponse(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: 40,
        height: 40,
        decoration: isSelected
            ? BoxDecoration(
                color: itemColor,
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}





