import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    HomeScreen(),
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
            icon: Icon(Icons.home),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.slideshow),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_mall),
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
