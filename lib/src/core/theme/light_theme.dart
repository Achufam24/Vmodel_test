import 'package:flutter/material.dart';
import 'package:vmodel/src/core/constants/app_colors.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.white,
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.white,
    elevation: 0,
    surfaceTintColor: Colors.transparent

  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: AppColors.textPrimaryColor,
  ),
);