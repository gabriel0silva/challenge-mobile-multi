import 'package:challenge_mobile_multi/app/core/utils/app_assets.dart';
import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/splash_screen_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/widgets/default_scaffold.dart';
import 'package:challenge_mobile_multi/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashScreenViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = getIt<SplashScreenViewModel>();
    vm.init(() {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold.withOpacity(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Lottie.asset(AppAssets.spashAnimation),
        ),
      ),
    );
  }
}

