import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppColors.gradientBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontFamily: AppFonts.montserratBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
