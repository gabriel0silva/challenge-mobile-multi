import 'package:challenge_mobile_multi/app/core/constants/app_config.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/auth_repository.dart';
import 'package:challenge_mobile_multi/app/services/dio_service.dart';
import 'package:challenge_mobile_multi/app/services/token_storage_service.dart';
import 'package:flutter/material.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioService _apiService;
  final TokenStorageService _tokenStorage;

  AuthRepositoryImpl(this._apiService, this._tokenStorage);

  @override
  Future<String?> fetchGuestToken() async {
    try {
      final savedToken = _tokenStorage.getToken();

      if (savedToken != null && savedToken.isNotEmpty) {
        return savedToken;
      }

      final response = await _apiService.get('/authentication/guest_session/new');
      if (response.statusCode == 200 && response.data['success']) {

        final guestToken = response.data['guest_session_id'];
        await _tokenStorage.saveToken(guestToken);
        
        return guestToken;
      } 

      return null;
    } catch (e) {
      debugPrint('Error in fetchGuestToken() => $e');
      return null;
    }
  }

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

    // Função para validar se o token ainda é válido
  Future<bool> _validateToken(String token) async {
    try {
      // Faça uma requisição simples para validar o token, como uma consulta de perfil
      final response = await _apiService.get('/authentication/validate_token?token=$token');
      
      if (response.statusCode == 200 && response.data['success']) {
        return true; // O token é válido
      } else {
        return false; // O token não é válido
      }
    } catch (e) {
      debugPrint('Error validating token: $e');
      return false; // Falha na validação, então retornamos false
    }
  }
}