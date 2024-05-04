import 'package:flutter/material.dart';

class ScreenConfig {
  final BuildContext context;
  static late double screenHeight;
  static late double screenWidth;

  ScreenConfig({required this.context}) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.height;
  }
}
