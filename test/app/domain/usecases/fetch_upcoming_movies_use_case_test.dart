import 'dart:ui';

import 'package:challenge_mobile_multi/app/core/constants/app_config.dart';
import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/core/constants/poster_sizes.dart';
import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/movies_repository.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_upcoming_movies_use_case.dart';
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
  late FetchUpcomingMoviesUseCase mockFetchUpcomingMoviesUseCase;
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
    mockFetchUpcomingMoviesUseCase = FetchUpcomingMoviesUseCase(mockRepository);
  });

  group('FetchUpcomingMoviesUseCase', () {
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

    test('call returns MoviesModel when repository returns data', () async {
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
      
      final moviesModel = MoviesModel.fromJson(successDataMovies);

      when(() => mockRepository.fetchUpComingMovies()).thenAnswer((_) async => moviesModel);

      final result = await mockFetchUpcomingMoviesUseCase.call();

      expect(result, isNotNull);
      expect(result, isA<MoviesModel>());
      verify(() => mockRepository.fetchUpComingMovies()).called(1);
    });

    test('call returns null when repository returns null', () async {
      when(() => mockRepository.fetchUpComingMovies()).thenAnswer((_) async => null);

      final result = await mockFetchUpcomingMoviesUseCase.call();

      expect(result, isNull);
      verify(() => mockRepository.fetchUpComingMovies()).called(1);
    });
  });
}