import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.white),
    useMaterial3: true, 
  );
}