import 'package:challenge_mobile_multi/app/presentation/viewmodels/home_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppInitializer {
  Future<void> initializeApp(HomeScreenViewmodel homeScreenViewmodel) async {
    try {
      await dotenv.load(fileName: ".env");
      await homeScreenViewmodel.loadData();
    } catch (e) {
      debugPrint('Error in initializeApp() -> $e');
    }
  }
}
