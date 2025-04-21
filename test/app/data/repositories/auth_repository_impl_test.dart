import 'package:challenge_mobile_multi/app/core/constants/app_config.dart';
import 'package:challenge_mobile_multi/app/data/repositories/auth_repository_impl.dart';
import 'package:challenge_mobile_multi/app/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockDioService extends Mock implements DioService {}

class MockResponse extends Mock implements Response {}

final getIt = GetIt.instance;
void main() {
  late AuthRepositoryImpl repository;
  late MockDioService mockDioService;
  late MockResponse mockResponse;

  setUp(() {
    getIt.reset();
    mockDioService = MockDioService();
    getIt.registerSingleton<DioService>(mockDioService);
    repository = AuthRepositoryImpl(mockDioService);
    mockResponse = MockResponse();
  });

  group('AuthRepositoryImpl', () {
    final successData = {
      'images': {
        'base_url': 'http://image.tmdb.org/t/p/',
        'secure_base_url': 'https://image.tmdb.org/t/p/',
        'backdrop_sizes': [
          'w300',
          'w780',
          'w1280',
          'original'
        ],
        'logo_sizes': [
          'w45',
          'w92',
          'w154',
          'w185',
          'w300',
          'w500',
          'original'
        ],
        'poster_sizes': [
          'w92',
          'w154',
          'w185',
          'w342',
          'w500',
          'w780',
          'original'
        ],
        'profile_sizes': [
          'w45',
          'w185',
          'h632',
          'original'
        ],
        'still_sizes': [
          'w92',
          'w185',
          'w300',
          'original'
        ]
      }
    };

    // TOP RATED MOVIES
    test('fetchApiConfigurations returns AppConfig when successful', () async {
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.data).thenReturn(successData);

      when(() => mockDioService.get(any(),queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => mockResponse);

      final result = await repository.fetchApiConfigurations();

      expect(result, isNotNull);

      expect(result, isA<AppConfig>());
    });

    test('fetchApiConfigurations returns null when status is not 200', () async {
      when(() => mockResponse.statusCode).thenReturn(404);
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => mockResponse);

      final result = await repository.fetchApiConfigurations();

      expect(result, isNull);
    });

    test('fetchApiConfigurations returns null on error', () async {
      when(() => mockDioService.get(any(),queryParameters: any(named: 'queryParameters'))).thenThrow(Exception());

      final result = await repository.fetchApiConfigurations();

      expect(result, isNull);
    });
  });
}
