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
  double screenWidth = 0;

  final tabs = [
    const Center(child: HomePage()),
    const Center(child: WatchlistPage()),
    const Center(child: ProfilePage()),
  ];

  void _changeSelectedNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size().init(context);
    screenWidth = Size.screenWidth;

    return Scaffold(
      body: tabs[_selectedNavbar],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: priBlue,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const [
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
          // elevation: 20,
          currentIndex: _selectedNavbar,
          iconSize: screenWidth < 425 ? 24 : 36,
          onTap: _changeSelectedNavbar,
          showUnselectedLabels: false,
          backgroundColor: priBlue,
          selectedItemColor: accGreen,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
