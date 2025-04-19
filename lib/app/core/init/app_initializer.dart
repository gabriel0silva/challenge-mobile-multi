import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/auth_repository.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';

class AppInitializer {
  final AuthRepository _authRepository;

  AppInitializer(this._authRepository);

  static const int minSecondsDuringSplashPage = 3;

  Future<void> initializeApp(HomeViewModel homeVM) async {
    try {
      final start = DateTime.now();

      // await _authRepository.fetchGuestToken();

      final configurations = await _authRepository.fetchApiConfigurations();
      if (configurations != null) {
        Data.appConfig = configurations;
      }

      await homeVM.init();

      final durationSeconds = DateTime.now().difference(start).inSeconds;

      // Essa validação é para que se as chamadas forem menores que 3 segundos (Tempo ideal da minha animação da Splash) minha Splash page vai sempre aparecer a animação no tempo correto
      if (durationSeconds < minSecondsDuringSplashPage) {
        await Future.delayed(Duration(seconds: minSecondsDuringSplashPage - durationSeconds));
      }
    } catch (e) {
      debugPrint('Erro ao inicializar o app: $e');
    }
  }
}
