import 'package:challenge_mobile_multi/app/core/theme/app_theme.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/home_screen_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/splash_screen_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:challenge_mobile_multi/app/routes/app_router.dart';
import 'package:challenge_mobile_multi/app/routes/app_routes.dart';
import 'package:challenge_mobile_multi/app/services/app_initializer.dart';
import 'package:challenge_mobile_multi/l10n/app_localizations.dart';
import 'package:challenge_mobile_multi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AppInitializer()),
        ChangeNotifierProvider(create: (_) => HomeScreenViewmodel()),
        ChangeNotifierProvider(
          create: (context) => SplashScreenViewModel(initializer: AppInitializer(), homeScreenVM: context.read<HomeScreenViewmodel>()),
        ),
        ChangeNotifierProvider(create: (_) => LocaleViewModel()),
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
          );
        }
      ),
    );
  }
}