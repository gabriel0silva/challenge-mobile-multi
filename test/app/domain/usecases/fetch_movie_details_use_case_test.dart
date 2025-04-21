import 'dart:ui';

import 'package:challenge_mobile_multi/app/core/constants/app_config.dart';
import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/core/constants/poster_sizes.dart';
import 'package:challenge_mobile_multi/app/data/models/movie_details_model.dart';
import 'package:challenge_mobile_multi/app/domain/entities/trailer_result.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/movies_repository.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_movie_details_use_case.dart';
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
class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  late MockDioService mockDioService;
  late MockLocaleViewModel mockLocaleViewModel;
  late FetchMovieDetailsUseCase mockFetchMovieDetailsUseCase;
  late MockMoviesRepository mockRepository;

  setUp(() {
    getIt.reset();
    mockDioService = MockDioService();
    getIt.registerSingleton<DioService>(mockDioService);

    mockLocaleViewModel = MockLocaleViewModel();
    getIt.registerSingleton<LocaleViewModel>(mockLocaleViewModel);
    when(() => mockLocaleViewModel.apiLanguageParam).thenReturn('pt-BR');
    when(() => mockLocaleViewModel.locale).thenReturn(const Locale('pt'));

    mockRepository = MockMoviesRepository();
    mockFetchMovieDetailsUseCase = FetchMovieDetailsUseCase(mockRepository);
  });

  group('FetchMovieDetailsUseCase', () {
    final successDataMoviesDetail = {
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

    test('call returns MovieDetailsModel when repository returns data', () async {
      Data.appConfig = AppConfig(
        imageBaseUrl: 'https://image.tmdb.org/t/p/', 
        imageSizes: ImageSizes(
          poster: PosterSizes(
            w92: '', 
            w154: '', 
            w185: '', 
            w342: '', 
            w500: '', 
            w780: '', 
            original: 'original',
          ), 
          backdrop: BackdropSizes(
            w300: '', 
            w780: '', 
            w1280: '',
            original: 'original',
          ),
        ),
      );
      
      final movieDetailsModel = MovieDetailsModel.fromJson(successDataMoviesDetail, '16', const TrailerResult(type: TrailerType.youtubeKey, value: '/oasiudnalkshdasd'));

      when(() => mockRepository.fetchDetailsMovie(movieId: 155, movieTitle: 'Batman: Cavalheiro das trevas')).thenAnswer((_) async => movieDetailsModel);

      final result = await mockFetchMovieDetailsUseCase.call(155, 'Batman: Cavalheiro das trevas');

      expect(result, isNotNull);
      expect(result, isA<MovieDetailsModel>());
      verify(() => mockRepository.fetchDetailsMovie(movieId: 155, movieTitle: 'Batman: Cavalheiro das trevas')).called(1);
    });

    test('call returns null when repository returns null', () async {
      when(() => mockRepository.fetchDetailsMovie(movieId: 155, movieTitle: 'Batman: Cavalheiro das trevas')).thenAnswer((_) async => null);

      final result = await mockFetchMovieDetailsUseCase.call(155, 'Batman: Cavalheiro das trevas');

      expect(result, isNull);
      verify(() => mockRepository.fetchDetailsMovie(movieId: 155, movieTitle: 'Batman: Cavalheiro das trevas')).called(1);
    });
  });
}