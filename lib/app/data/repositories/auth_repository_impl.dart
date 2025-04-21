import 'package:challenge_mobile_multi/app/core/constants/app_config.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/auth_repository.dart';
import 'package:challenge_mobile_multi/app/services/dio_service.dart';
import 'package:flutter/material.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Future<AppConfig?> fetchApiConfigurations() async {
    try {
      final response = await _apiService.get(
        '/configuration',
      );
      if (response.statusCode == 200 && response.data['images'] != null) {
        return AppConfig.fromJson(response.data);
      }

      return null;
    } catch (e) {
      debugPrint('Error in fetchApiConfigurations() => $e');
      return null;
    }
  }
}