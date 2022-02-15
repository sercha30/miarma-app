import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miarma_app/screens/home_screen.dart';
import 'package:flutter_miarma_app/screens/profile_screen.dart';
import 'package:flutter_miarma_app/screens/search_screen.dart';

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
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/mock-profile-photo.png',
              width: 25,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        activeColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
