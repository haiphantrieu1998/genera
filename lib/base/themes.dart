import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Themes {
  static TextStyle copyStyle(
          {Color color,
          FontWeight fontWeight = FontWeight.normal,
          double fontSize = 14,
          double letterSpacing,
          TextDecoration decoration}) =>
      TextStyle(
          fontSize: fontSize,
          color: color ?? grey,
          fontWeight: fontWeight ?? FontWeight.w400,
          letterSpacing: letterSpacing,
          fontFamily: font,
          decoration: decoration);
  static TextStyle appBar() =>
      copyStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600);

  static const Color mainColor = Color(0xFF653B8F);
  static const Color purple = Color(0xFFA561DB);
  static const Color yellow = Color(0xFFFFC107);
  static const Color yellow50 = Color(0xFFFFE082);
  static const Color red = Color(0xFFD82121);
  static const Color red50 = Color(0xFFF5DCDC);
  static const Color grey = Color(0xFF606060);
  static const Color grey300 = Color(0xFF2E2D31);
  static const Color grey250 = Color(0xFF747474);
  static const Color grey200 = Color(0xFF989898);
  static const Color grey100 = Color(0xFFCFCFCF);
  static const Color grey50 = Color(0xFFF2F2F2);
  static const Color white = Colors.white;
  static const Color white100 = Color(0xFFF2F3F5);
  static const Color black = Colors.black;
  static const Color blue = Colors.blue;
  static const String font = 'Gotham';

}
