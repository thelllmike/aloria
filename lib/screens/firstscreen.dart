import 'package:aloria/screens/chat.dart';
import 'package:aloria/screens/testresult.dart';
import 'package:aloria/screens/utils/global_user.dart';
import 'package:aloria/theme/app_colors.dart';
import 'package:aloria/widgets/bottom_nav.dart';
import 'package:aloria/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _selectedIndex = 0; // Active index for bottom navigation

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Extract the first name from GlobalUser.name
    String firstName = (GlobalUser.name != null && GlobalUser.name!.isNotEmpty)
        ? GlobalUser.name!.split(' ')[0]
        : "Anna";

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(), // Ensure you have a CustomDrawer widget
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(context, firstName),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'RECENT TESTS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Bebas Neue',
                        fontSize: 18.0,
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
                      margin: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 4.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                        leading: CircleAvatar(
                          radius: 44,
                          backgroundImage: NetworkImage(GlobalUser.profilePictureUrl ?? 'assets/images/pro.png'),
                        ),
                        title: const Text(
                          'Oily skin',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'Fair tone',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18.0,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        trailing: const Icon(UniconsLine.angle_right_b, color: Colors.white, size: 52.0,),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => TestResultsScreen(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'SKIN TYPES',
                      style: TextStyle(
                        fontFamily: 'Bebas Neue',
                        fontSize: 18.0,
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
        ],
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

  SliverAppBar _buildSliverAppBar(BuildContext context, String firstName) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      leading: IconButton(
        icon: const Icon(UniconsLine.paragraph, color: Colors.black),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),  // This opens the drawer
      ),
      title: Text(
        'Hi, $firstName',
        style: const TextStyle(
          fontFamily: 'Nunito',
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(UniconsLine.comments, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()), // Navigate to ChatScreen
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48.0), // Height for the search area
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding for the AppBar's bottom area
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the leading and trailing icons
            children: [
              const Icon(UniconsLine.filter, size: 20.0, color: Colors.grey), // Filter icon on the left
              Row(
                // Search area on the right
                mainAxisSize: MainAxisSize.min, // Takes the size of its children
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding inside the container for 'Oily skin' text
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Soft grey color for 'Oily skin' text background
                      borderRadius: BorderRadius.circular(24.0), // Rounded corners for the container
                    ),
                    child: const Text(
                      'Oily skin',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.black45,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0), // Space between 'Oily skin' text and search icon
                  const Icon(UniconsLine.search, size: 20.0, color: Colors.grey), // Search icon
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkinTypeIcon(BuildContext context, String label, String iconPath) {
    return Column(
      children: [
        Image.asset(iconPath, width: 52, height: 52),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontFamily: 'Nunito', fontSize: 15.0)),
      ],
    );
  }
}
