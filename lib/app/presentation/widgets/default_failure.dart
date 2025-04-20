import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_fonts.dart';
import 'package:challenge_mobile_multi/app/presentation/widgets/default_button.dart';
import 'package:challenge_mobile_multi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DefaultFailure extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;

  const DefaultFailure({
    super.key,
    this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: AppColors.blue,
            ),
            const SizedBox(height: 20),
            Text(
              'Opa, algo deu errado!',
              style: TextStyle(
                fontSize: 22,
                color: AppColors.white,
                fontFamily: AppFonts.montserratBold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message ?? 'Não conseguimos carregar os dados. Verifique sua conexão ou tente novamente.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.gray,
                fontFamily: AppFonts.montserratMedium,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            DefaultButton(
              title: l10n.translate('try_again'), 
              onTap: onRetry,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
