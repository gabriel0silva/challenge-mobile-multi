import 'package:challenge_mobile_multi/app/presentation/screens/details/details_screen.dart';
import 'package:challenge_mobile_multi/app/presentation/screens/home/home_screen.dart';
import 'package:challenge_mobile_multi/app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.details:
        return MaterialPageRoute(builder: (_) => const DetailsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}