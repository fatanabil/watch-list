import 'package:flutter/material.dart';
import 'package:movie_list/main_page.dart';
import 'package:movie_list/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: priBlue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accGreen),
      ),
      home: const MainPage(),
    );
  }
}
