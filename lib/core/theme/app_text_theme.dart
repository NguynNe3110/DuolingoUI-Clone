import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static const String _fontFamily = 'Nunito';

  static const TextTheme light = TextTheme(
    // headings
    displayLarge: TextStyle(fontFamily: _fontFamily, fontSize: 34, fontWeight: FontWeight.w800, letterSpacing: 0.4, height: 1.1),
    // title 1
    displayMedium: TextStyle(fontFamily: _fontFamily, fontSize: 30, fontWeight: FontWeight.w800),
    // title 2
    displaySmall: TextStyle(fontFamily: _fontFamily, fontSize: 28, fontWeight: FontWeight.w800),
    // long headings
    headlineLarge: TextStyle(fontFamily: _fontFamily, fontSize: 28, fontWeight: FontWeight.w700),
    // title 3
    headlineMedium: TextStyle(fontFamily: _fontFamily, fontSize: 24, fontWeight: FontWeight.w700),
    // title 4
    titleLarge: TextStyle(fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w600),
    // sub head
    titleMedium: TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w600),
    // body1
    bodyLarge: TextStyle(fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w500),
    // body2
    bodyMedium: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w500),
    // caption
    bodySmall: TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500),
    // button 1
    labelLarge: TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w700),
    // button 2
    labelMedium: TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w700),


  );
}