import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final Dio dio = Dio();

  Future<String?> createRequestToken() async {
    try {
      final response = await dio.get(
        'https://api.themoviedb.org/3/authentication/token/new',
        queryParameters: {
          'api_key': 'YOUR_API_KEY',
        },
      );

      if (response.statusCode == 200 && response.data['success']) {
        return response.data['request_token'];
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Erro ao criar o request_token: $e');
      return null;
    }
  }
}
