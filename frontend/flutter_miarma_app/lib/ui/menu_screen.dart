import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miarma_app/ui/new_post_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    HomeScreen(),
    SearchScreen(),
    NewPostScreen(),
    HomeScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_mall_outlined),
          ),
          BottomNavigationBarItem(
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/mock-profile-photo.jpg',
                width: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        activeColor: Colors.black,
        onTap: _onItemTapped,
        border: const Border.fromBorderSide(BorderSide.none),
        iconSize: 28.0,
      ),
    );
  }
}
