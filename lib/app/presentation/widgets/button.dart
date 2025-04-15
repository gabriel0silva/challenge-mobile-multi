import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final double radius;
  final VoidCallback onTap;

  const Button({
    required this.text,
    required this.onTap,
    required this.radius,
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [AppColors.gadientBlue100, AppColors.gadientBlue50]),
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          text, 
          textAlign: TextAlign.center, 
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontFamily: AppFonts.montserratBold,
          ),
        ),
      ),
    );
  }
}