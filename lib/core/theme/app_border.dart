import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design Token: Viền (Border)
class AppBorder {
  AppBorder._();

  static const double b1 = 1.0;
  static const double b2 = 2.0; // Viền tiêu chuẩn của Duolingo
  static const double b3 = 3.0;

  /// Viền đen tiêu chuẩn của Duolingo
  static Border standard() {
    return Border.all(color: AppColors.borderDark, width: b2);
  }

  static BorderSide standardSide() {
    return const BorderSide(color: AppColors.borderDark, width: b2);
  }
}