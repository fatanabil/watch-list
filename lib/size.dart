import 'package:flutter/material.dart';

class Size {
  static late MediaQueryData mediaQuery;
  static late double screenWidth;
  static late double screenHeight;

  void init(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }
}
