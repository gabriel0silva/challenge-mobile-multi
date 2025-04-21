import 'package:challenge_mobile_multi/app/data/models/movie_details_model.dart';
import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';
import 'package:challenge_mobile_multi/app/data/repositories/movies_repository_impl.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:challenge_mobile_multi/app/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

final getIt = GetIt.instance;

class MockDioService extends Mock implements DioService {}
class MockResponse extends Mock implements Response {}
class MockLocaleViewModel extends Mock implements LocaleViewModel {}

void main() {
  late MoviesRepositoryImpl repository;
  late MockDioService mockDioService;
  late MockResponse mockResponse;
  late MockLocaleViewModel mockLocaleViewModel;

  setUp(() {
    getIt.reset();
    mockDioService = MockDioService();
    getIt.registerSingleton<DioService>(mockDioService);
    mockLocaleViewModel = MockLocaleViewModel();
    getIt.registerSingleton<LocaleViewModel>(mockLocaleViewModel);
    repository = MoviesRepositoryImpl(mockDioService);
    when(() => mockLocaleViewModel.apiLanguageParam).thenReturn('pt-BR');
    mockResponse = MockResponse();
  });

  group('MoviesRepositoryImpl', () {
    final successDataMovies = {
      'page': 1,
      'results': [
        {
          'adult': false,
          'backdrop_path': '/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg',
          'genre_ids': [
            18,
            80
          ],
          'id': 278,
          'original_language': 'en',
          'original_title': 'The Shawshank Redemption',
          'overview': 'Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.',
          'popularity': 40.5118,
          'poster_path': '/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg',
          'release_date': '1994-09-23',
          'title': 'The Shawshank Redemption',
          'video': false,
          'vote_average': 8.708,
          'vote_count': 28161
        },
      ],
      'total_pages': 505,
      'total_results': 10098
    };
    
    final successDataDetailsMovie = {
      'adult': false,
      'backdrop_path': '/oOv2oUXcAaNXakRqUPxYq5lJURz.jpg',
      'belongs_to_collection': {
        'id': 263,
        'name': 'The Dark Knight Collection',
        'poster_path': '/ogyw5LTmL53dVxsppcy8Dlm30Fu.jpg',
        'backdrop_path': '/xyhrCEdB4XRkelfVsqXeUZ6rLHi.jpg'
      },
      'budget': 185000000,
      'genres': [
        {
          'id': 18,
          'name': 'Drama'
        },
        {
          'id': 28,
          'name': 'Action'
        },
        {
          'id': 80,
          'name': 'Crime'
        },
        {
          'id': 53,
          'name': 'Thriller'
        }
      ],
      'homepage': 'https://www.warnerbros.com/movies/dark-knight/',
      'id': 155,
      'imdb_id': 'tt0468569',
      'origin_country': [
        'US'
      ],
      'original_language': 'en',
      'original_title': 'The Dark Knight',
      'overview': 'Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.',
      'popularity': 38.1755,
      'poster_path': '/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      'production_companies': [
        {
          'id': 174,
          'logo_path': '/zhD3hhtKB5qyv7ZeL4uLpNxgMVU.png',
          'name': 'Warner Bros. Pictures',
          'origin_country': 'US'
        },
        {
          'id': 923,
          'logo_path': '/5UQsZrfbfG2dYJbx8DxfoTr2Bvu.png',
          'name': 'Legendary Pictures',
          'origin_country': 'US'
        },
        {
          'id': 9996,
          'logo_path': '/3tvBqYsBhxWeHlu62SIJ1el93O7.png',
          'name': 'Syncopy',
          'origin_country': 'GB'
        },
        {
          'id': 429,
          'logo_path': '/4Y00XuSMuP1gimd0jP6JT57QbCI.png',
          'name': 'DC',
          'origin_country': 'US'
        }
      ],
      'production_countries': [
        {
          'iso_3166_1': 'GB',
          'name': 'United Kingdom'
        },
        {
          'iso_3166_1': 'US',
          'name': 'United States of America'
        }
      ],
      'release_date': '2008-07-16',
      'revenue': 1004558444,
      'runtime': 152,
      'spoken_languages': [
        {
          'english_name': 'English',
          'iso_639_1': 'en',
          'name': 'English'
        },
        {
          'english_name': 'Mandarin',
          'iso_639_1': 'zh',
          'name': '普通话'
        }
      ],
      'status': 'Released',
      'tagline': 'Welcome to a world without rules.',
      'title': 'The Dark Knight',
      'video': false,
      'vote_average': 8.519,
      'vote_count': 33740
    };

    // TOP RATED MOVIES
    test('fetchTopRatedMovies returns MoviesModel when successful', () async {
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.data).thenReturn(successDataMovies);

      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => mockResponse);

      // Executa o teste
      final result = await repository.fetchTopRatedMovies();

      expect(result, isNotNull);

      expect(result, isA<MoviesModel>());
    });

    test('fetchTopRatedMovies returns null when status is not 200', () async {
      when(() => mockResponse.statusCode).thenReturn(404);
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => mockResponse);

      final result = await repository.fetchTopRatedMovies();

      expect(result, isNull);
    });

    test('fetchTopRatedMovies returns null on error', () async {
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters'))).thenThrow(Exception());

      final result = await repository.fetchTopRatedMovies();
      
      expect(result, isNull);
    });

    // UPCOMING MOVIES
  test('fetchUpComingMovies send page 2', () async {
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.data).thenReturn(successDataMovies);
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => mockResponse);

      final result = await repository.fetchUpComingMovies(page: 3);

      expect(result, isNotNull);
      expect(result, isA<MoviesModel>());

      verify(() => mockDioService.get(
        '/movie/upcoming',
        queryParameters: {
          'page': 2,
          'language': mockLocaleViewModel.apiLanguageParam,
        },
      )).called(1);
    });

    test('fetchUpComingMovies returns null when status is not 200', () async {
      when(() => mockResponse.statusCode).thenReturn(404);
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => mockResponse);

      final result = await repository.fetchUpComingMovies();

      expect(result, isNull);
    });

    test('fetchUpComingMovies returns null on error', () async {
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters'))).thenThrow(Exception());

      final result = await repository.fetchUpComingMovies();

      expect(result, isNull);
    });

    // NOW PLAYING MOVIES
    test('fetchNowPlayingMovies returns MoviesModel when successful', () async {
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.data).thenReturn(successDataMovies);
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => mockResponse);

      final result = await repository.fetchNowPlayingMovies();

      expect(result, isNotNull);
      expect(result, isA<MoviesModel>());
    });

    test('fetchNowPlayingMovies returns null when status is not 200', () async {
      when(() => mockResponse.statusCode).thenReturn(404);
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => mockResponse);

      final result = await repository.fetchNowPlayingMovies();

      expect(result, isNull);
    });

    test('fetchNowPlayingMovies returns null on error', () async {
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters'))).thenThrow(Exception());

      final result = await repository.fetchNowPlayingMovies();

      expect(result, isNull);
    });

    // DETAILS MOVIE
    test('fetchDetailsMovie returns MoviesModel when successful', () async {
      when(() => mockResponse.statusCode).thenReturn(200);
      when(() => mockResponse.data).thenReturn(successDataDetailsMovie);
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => mockResponse);

      final result = await repository.fetchDetailsMovie(movieId: 155, movieTitle: 'Batman: Cavalheiro das Trevas');

      expect(result, isNotNull);
      expect(result, isA<MovieDetailsModel>());
    });

    test('fetchDetailsMovie returns null when status is not 200', () async {
      when(() => mockResponse.statusCode).thenReturn(404);
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => mockResponse);

      final result = await repository.fetchDetailsMovie(movieId: 155, movieTitle: 'Batman: Cavalheiro das Trevas');

      expect(result, isNull);
    });

    test('fetchDetailsMovie returns null on error', () async {
      when(() => mockDioService.get(any(), queryParameters: any(named: 'queryParameters'))).thenThrow(Exception());

      final result = await repository.fetchDetailsMovie(movieId: 155, movieTitle: 'Batman: Cavalheiro das Trevas');

      expect(result, isNull);
    });
  });
}