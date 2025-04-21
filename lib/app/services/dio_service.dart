import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioService {
  Dio dio = Dio();

  DioService() : dio = (() {
    final apiKey = dotenv.env['API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API_KEY não encontrada no .env');
    }

    return Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
      ),
    );
  })();

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) {
    return dio.put(path, data: data);
  }

  Future<Response> delete(String path) {
    return dio.delete(path);
  }
}
