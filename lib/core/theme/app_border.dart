import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design Token: Viền (Border)
class AppBorder {
  AppBorder._();

  static const double thin = 1.0;
  static const double medium = 2.0; // Viền tiêu chuẩn của Duolingo
  static const double thick = 3.0;

  /// Viền đen tiêu chuẩn của Duolingo
  static Border standard() {
    return Border.all(color: AppColors.borderDark, width: medium);
  }

  static BorderSide standardSide() {
    return const BorderSide(color: AppColors.borderDark, width: medium);
  }
}