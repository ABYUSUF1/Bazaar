import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static TextStyle style10NormalLightGrey = const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: AppColors.foregroundColor2);

  static TextStyle style12BoldLightGrey = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: AppColors.foregroundColor2);

  static TextStyle style12Normal =
      const TextStyle(fontSize: 12, color: AppColors.foregroundColor);

  static TextStyle style14W600 = const TextStyle(
      fontSize: 14,
      color: AppColors.foregroundColor,
      fontWeight: FontWeight.w600);

  static TextStyle style14Normal = const TextStyle(
      fontSize: 14,
      color: AppColors.foregroundColor,
      fontWeight: FontWeight.normal);

  static TextStyle style16Bold = const TextStyle(
      fontSize: 16,
      color: AppColors.foregroundColor,
      fontWeight: FontWeight.bold);

  static TextStyle style20Bold = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.foregroundColor);

  static TextStyle style26Bold = const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: AppColors.foregroundColor);

  static TextStyle style36Bold = const TextStyle(
      fontSize: 36, color: AppColors.whiteColor, fontWeight: FontWeight.bold);
}
