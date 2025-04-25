import 'package:flutter/material.dart';
import 'app_colors.dart';

final appTheme = ThemeData.dark(useMaterial3: true).copyWith(
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.card,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
  ),
);
