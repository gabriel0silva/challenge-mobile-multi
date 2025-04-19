
import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color pink = Color(0xFFC60385);
  static const Color pink1 = Color(0xFFFF00BF);
  static const Color yellow = Color(0xFFFFBB00);
  static const Color yellow1 = Color(0xFFFFC700);
  static const Color gray = Color(0xFFADADAD);
  static const Color gray1 = Color(0xFFAEAEAE);
  static const Color gray3 = Color(0xFF999999);
  static const Color black = Color(0xFF000000);
  static const Color blackOppacity = Color(0x80000000);

  static const Color purple = Color(0xB3A800CA);
  static const Color blue2 = Color(0xFF00249A);
  static const Color blue1 = Color(0xFF005BB0);
  static const Color blue = Color(0xFF0084FF);

  static const LinearGradient gradientBlue = LinearGradient(colors: [AppColors.blue, AppColors.blue1]);
  static const LinearGradient gradientPurple = LinearGradient(colors: [AppColors.purple, AppColors.blue2], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static const LinearGradient gradientwhite = LinearGradient(colors: [AppColors.white, AppColors.gray3]);
}