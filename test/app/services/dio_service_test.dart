import 'package:challenge_mobile_multi/app/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock para o Dio e Response
class MockDio extends Mock implements Dio {}
class MockResponse extends Mock implements Response {}

void main() {
  late DioService dioService;
  late MockDio mockDio;

  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  setUp(() {
    dotenv.env['API_KEY'] = 'aspkakkkkkakkasjdjjjcjalkhquead';
    mockDio = MockDio();
    dioService = DioService();
    dioService.dio = mockDio;
  });

  group('DioService tests', () {
    test('get should return a map with the correct data', () async {
    final response = Response(
      data: {'key': 'value'},
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

    when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => response);

    final result = await dioService.get('path');

    expect(result.data, {'key': 'value'});
  });
    test('should throw an exception if API_KEY is not found in .env', () {
      dotenv.env.remove('API_KEY');
      expect(() => DioService(), throwsA(isA<Exception>()));
    });

    // Teste GET
    test('get should return a map with the correct data', () async {
      final response = Response(
        data: {'key': 'value'},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => response);

      final result = await dioService.get('path');
      expect(result.data, {'key': 'value'});
    });

    // Teste POST
    test('post should send data and return response', () async {
      final response = Response(
        data: {'key': 'value'},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer((_) async => response);

      final result = await dioService.post('path', data: {'key': 'value'});
      expect(result.data, {'key': 'value'});
    });

    // Teste PUT
    test('put should update data and return response', () async {
      final response = Response(
        data: {'key': 'value'},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(() => mockDio.put(any(), data: any(named: 'data'))).thenAnswer((_) async => response);

      final result = await dioService.put('path', data: {'key': 'value'});
      expect(result.data, {'key': 'value'});
    });

    // Teste DELETE
    test('delete should return a response with the expected data', () async {
      final response = Response(
        data: {'key': 'value'},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(() => mockDio.delete(any())).thenAnswer((_) async => response);

      final result = await dioService.delete('path');
      expect(result.data, {'key': 'value'});
    });

    test('should handle error when GET request fails', () async {
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'))).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(() async => await dioService.get('/path'), throwsA(isA<DioException>()));
    });

    test('should handle error when POST request fails', () async {
      final postData = {'name': 'test'};
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(() async => await dioService.post('/path', data: postData), throwsA(isA<DioException>()));
    });

    test('should handle error when PUT request fails', () async {
      final putData = {'name': 'test'};
      when(() => mockDio.put(any(), data: any(named: 'data'))).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(() async => await dioService.put('/path', data: putData), throwsA(isA<DioException>()));
    });

    test('should handle error when DELETE request fails', () async {
      when(() => mockDio.delete(any())).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(() async => await dioService.delete('/path'), throwsA(isA<DioException>()));
    });
  });
}
