import 'package:flutter/material.dart';
import 'package:movie_list/home_page.dart';
import 'package:movie_list/profile_page.dart';
import 'package:movie_list/size.dart';
import 'package:movie_list/theme.dart';
import 'package:movie_list/watchlist_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedNavbar = 0;

  final tabs = [
    Center(child: HomePage()),
    Center(child: WatchlistPage()),
    Center(child: ProfilePage()),
  ];

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size().init(context);

    return Scaffold(
      body: tabs[_selectedNavbar],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: 'WatchList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: 'Profile',
          ),
        ],
        elevation: 20,
        currentIndex: _selectedNavbar,
        iconSize: 36,
        onTap: _changeSelectedNavbar,
        showUnselectedLabels: false,
        backgroundColor: priBlue,
        selectedItemColor: accGreen,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
