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

// class AppTheme {
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     colorScheme: const ColorScheme.light(
//       primary: AppColors.primary,
//       surface: AppColors.background,
//       onSurface: AppColors.textPrimary,
// ColorScheme.light( //là màu của material , khi khai báo thé này nó sẽ ghi đè để dùng  màu mình khai báo
// primary: ...,      // Màu chính, nút, AppBar, highlight
// onPrimary: ...,    // Màu chữ/icon trên primary
// secondary: ...,    // Màu phụ
// onSecondary: ...,  // Màu chữ/icon trên secondary
// surface: ...,      // Màu nền bề mặt
// onSurface: ...,    // Màu chữ/icon trên surface
// error: ...,        // Màu lỗi
// onError: ...,      // Màu chữ/icon trên error
// )

//     ),
//     textTheme: const TextTheme( // nó sẽ ghi  đề bằng giá trị mà mình khai báo đối với textStyle
//       titleLarge: AppTextStyles.title,
//     ),
//   );
// }

// class AppTheme { // thường thì sẽ dùng 2 loại dark và light thế này
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     scaffoldBackgroundColor: AppColors.lightBackground,
//     colorScheme: const ColorScheme.light(
//       surface: AppColors.lightBackground,
//     ),
//   );
//
//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     scaffoldBackgroundColor: AppColors.darkBackground,
//     colorScheme: const ColorScheme.dark(
//       surface: AppColors.darkBackground,
//     ),
//   );
// }