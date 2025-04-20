import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_fonts.dart';
import 'package:challenge_mobile_multi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DefaultLoading extends StatelessWidget {
  final String? message;
  
  const DefaultLoading({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          const CircularProgressIndicator(color: AppColors.blue),
          Text(
            message ?? l10n.translate('loading'),
            style: TextStyle(
              fontSize: 16,
              color: AppColors.white,
              fontFamily: AppFonts.montserratSemiBold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      )
    );
  }
}
