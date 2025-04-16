import 'package:challenge_mobile_multi/app/core/utils/app_assets.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_fonts.dart';
import 'package:challenge_mobile_multi/app/presentation/states/home_state.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/home_screen_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/widgets/default_scaffold.dart';
import 'package:challenge_mobile_multi/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    String? selectedValue = l10n.translate('portuguese');

    return Consumer<HomeScreenViewmodel>(builder: (context, vm, _) {
      switch (vm.state) {
        case HomeState.success:
          return const SizedBox();
        case HomeState.loading:
          return const CircularProgressIndicator();
        case HomeState.failure:
          return const Text('Erro');
        case HomeState.initial:
          return _successWidget(l10n, selectedValue, context);
      }
    });
  }
}

DefaultScaffold _successWidget(AppLocalizations l10n, String selectedValue, BuildContext context) {
  return DefaultScaffold(
    appBar: AppBar(
      toolbarHeight: 70,
      titleSpacing: 16,
      backgroundColor: Colors.transparent,
      actions: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(
              AppAssets.svgIconProfile,
            ),
          ),
        ),
      ],
      title: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              l10n.translate('language'),
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontFamily: AppFonts.montserratMedium,
              ),
            ),
            Row(
              spacing: 4,
              children: [
                SvgPicture.asset(
                  AppAssets.svgIconLocation,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedValue,
                  underline: const SizedBox(),
                  isDense: true,
                  dropdownColor: Colors.transparent,
                  style: const TextStyle(color: AppColors.white),
                  iconEnabledColor: AppColors.white,
                  padding: EdgeInsets.zero,
                  onChanged: (String? newValue) {
                    context.read<LocaleViewModel>().setLocale(newValue == l10n.translate('portuguese') ? const Locale('pt') : const Locale('en'));
                  },
                  items: [
                    l10n.translate('portuguese'),
                    l10n.translate('english')
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontFamily: AppFonts.montserratMedium,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    body: SafeArea(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.red,
          )
        ],
      ),
    )
  );
}
