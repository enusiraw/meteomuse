import 'package:flutter/material.dart';

class MyColors {
  static Color primaryColorBg = const Color.fromARGB(255, 35, 35, 41);
  static Color primaryColor = const Color.fromARGB(255, 47, 49, 58);
  static Color secondaryColor = const Color.fromARGB(255, 44, 45, 61);
  static Color backgroungPrimary = const Color.fromARGB(255, 72, 75, 91);
  static Color darkercolor = const Color.fromARGB(255, 28, 27, 27);
  static Color textColorwhite = const Color.fromARGB(255, 10, 42, 75);
  static Color lighttextcolor = const Color.fromARGB(255, 84, 87, 96);
  static  LinearGradient linearGradient = LinearGradient(
    colors: [Color.fromARGB(255, 72, 75, 91),  Color.fromARGB(255, 35, 35, 41)], 
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
