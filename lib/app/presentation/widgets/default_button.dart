import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final bool offstage;
  final String title;
  final VoidCallback onTap;
  final double width;

  const DefaultButton({
    this.offstage = false,
    this.width = double.infinity,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: offstage,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 16),
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            gradient: AppColors.gradientBlue,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontFamily: AppFonts.montserratBold,
              color: AppColors.white, 
            ),
          ),
        ),
      ),
    );
  }
}
