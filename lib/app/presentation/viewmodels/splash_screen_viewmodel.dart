import 'package:challenge_mobile_multi/app/presentation/viewmodels/home_screen_viewmodel.dart';
import 'package:challenge_mobile_multi/app/services/app_initializer.dart';
import 'package:flutter/material.dart';

class SplashScreenViewModel extends ChangeNotifier {
  SplashScreenViewModel({
    required this.initializer,
    required this.homeScreenVM,
  });

  final AppInitializer initializer;
  final HomeScreenViewmodel homeScreenVM;

  Future<void> initApp(Function onDone) async {
    await initializer.initializeApp(homeScreenVM);
    onDone();
  }
}
