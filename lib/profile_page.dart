import 'package:flutter/material.dart';
import 'package:movie_list/size.dart';
import 'package:movie_list/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dBlue,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 24),
          width: Size.screenWidth,
          height: Size.screenHeight,
          child: Column(
            children: [
              Text(
                'Your Profile',
                style: menuTitle.copyWith(fontSize: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
