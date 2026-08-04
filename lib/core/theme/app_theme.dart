import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,

    fontFamily: 'Nunito',

    scaffoldBackgroundColor: AppColors.background,

    // colorScheme: ColorScheme.fromSeed(
    //   seedColor: AppColors.primary,
    // ),

    textTheme: AppTextTheme.light,
  );
}