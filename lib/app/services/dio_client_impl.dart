import 'package:challenge_mobile_multi/app/services/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClientImpl implements RestClient {
  final Dio dio = Dio();

  @override
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      debugPrint("Error on GET request: $e");
      rethrow;
    }
  }

  // @override
  // Future<dynamic> post(String url, {Map<String, dynamic>? data}) async {
  //   try {
  //     final response = await dio.post(url, data: data);
  //     return response.data;
  //   } catch (e) {
  //     debugPrint("Error on POST request: $e");
  //     rethrow;
  //   }
  // }

  // @override
  // Future<dynamic> put(String url, {Map<String, dynamic>? data}) async {
  //   try {
  //     final response = await dio.put(url, data: data);
  //     return response.data;
  //   } catch (e) {
  //     debugPrint("Error on PUT request: $e");
  //     rethrow;
  //   }
  // }

  // @override
  // Future<dynamic> delete(String url, {Map<String, dynamic>? data}) async {
  //   try {
  //     final response = await dio.delete(url, data: data);
  //     return response.data;
  //   } catch (e) {
  //     debugPrint("Error on DELETE request: $e");
  //     rethrow;
  //   }
  // }
}
