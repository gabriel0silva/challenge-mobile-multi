import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/core/theme/app_theme.dart';
import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/details_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/home_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:challenge_mobile_multi/app/routes/app_router.dart';
import 'package:challenge_mobile_multi/app/routes/app_routes.dart';
import 'package:challenge_mobile_multi/app/services/translation_service.dart';
import 'package:challenge_mobile_multi/l10n/app_localizations.dart';
import 'package:challenge_mobile_multi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _fetchMediaQueryInformations(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<HomeViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<LocaleViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<DetailsViewModel>()),
      ],
      child: Consumer<LocaleViewModel>(
        builder: (context, vm, _) {
          return MaterialApp(
            title: 'Challenge Mobile Multi',
            debugShowCheckedModeBanner: false,
            supportedLocales: L10n.supportedLocales,
            locale: vm.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: AppRoutes.splash,
            theme: AppTheme.themeData,
            routes: AppRouter.appRoutes,
            builder: (context, child) {
              final l10n = AppLocalizations.of(context);
              getIt<TranslationService>().load(l10n);
              return child!;
            },
          );
        },
      ),
    );
  }
  void _fetchMediaQueryInformations(context) {
    MediaQueryData mediaQueryData = MediaQueryData.fromView(View.of(context));
    Data.height = mediaQueryData.size.height;
    Data.width = mediaQueryData.size.width;
    Data.scale = MediaQuery.textScalerOf(context);
  }
}
