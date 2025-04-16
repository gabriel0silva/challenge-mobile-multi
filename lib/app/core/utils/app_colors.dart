
import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color pink = Color(0xFFC60385);
  static const Color pink1 = Color(0xFFFF00BF);
  static const Color yellow = Color(0xFFFFBB00);
  static const Color yellow1 = Color(0xFFFFC700);
  static const Color gray = Color(0xFFADADAD);
  static const Color gray1 = Color(0xFFAEAEAE);
  static const Color black = Color(0xFF000000);
  static Color blackOppacity = const Color(0x80000000);

  // backgroud gradient
  static const Color gadientPurple50 = Color(0xFF121443);
  static const Color gadientPurple100 = Color(0xFF311448);
  static const Color gadientPurple150 = Color(0xFF2D0336);
  static const Color gadientPurple200 = Color(0xFF2D0032);

  static const Color gadientBlue50 = Color(0xFF005BB0);
  static const Color gadientBlue100 = Color(0xFF0084FF);
  static const LinearGradient gradientBlue = LinearGradient(colors: [AppColors.gadientBlue100, AppColors.gadientBlue50]);
}