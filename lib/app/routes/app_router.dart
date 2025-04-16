import 'package:challenge_mobile_multi/app/presentation/screens/details/details_screen.dart';
import 'package:challenge_mobile_multi/app/presentation/screens/home/home_screen.dart';
import 'package:challenge_mobile_multi/app/presentation/screens/splash/splash_screen.dart';
import 'package:challenge_mobile_multi/app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> appRoutes = {
    AppRoutes.splash: (_) => const SplashScreen(),
    AppRoutes.home: (_) => const HomeScreen(),
    AppRoutes.details: (_) => const DetailsScreen(),
  };
}
