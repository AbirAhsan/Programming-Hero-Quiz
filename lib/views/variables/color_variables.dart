import 'package:flutter/material.dart';

class CustomColors {
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Color(0xFF585858);
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static const Color darkBlue = Color(0xFF01203A);

  static MaterialColor primaryCustomColor = MaterialColor(0xFF01203A, color);
  static Map<int, Color> color = {
    50: const Color.fromRGBO(1, 32, 58, .1),
    100: const Color.fromRGBO(1, 32, 58, .2),
    200: const Color.fromRGBO(1, 32, 58, .3),
    300: const Color.fromRGBO(1, 32, 58, .4),
    400: const Color.fromRGBO(1, 32, 58, .5),
    500: const Color.fromRGBO(1, 32, 58, .6),
    600: const Color.fromRGBO(1, 32, 58, .7),
    700: const Color.fromRGBO(1, 32, 58, .8),
    800: const Color.fromRGBO(1, 32, 58, .9),
    900: const Color.fromRGBO(1, 32, 58, 1),
  };
}
