import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';
import 'package:challenge_mobile_multi/app/domain/entities/movies_result.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_all_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_now_playing_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_top_rated_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_upcoming_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

final getIt = GetIt.instance;

class MockFetchTopRatedMoviesUseCase extends Mock implements FetchTopRatedMoviesUseCase {}
class MockFetchNowPlayingMoviesUseCase extends Mock implements FetchNowPlayingMoviesUseCase {}
class MockFetchUpcomingMoviesUseCase extends Mock implements FetchUpcomingMoviesUseCase {}
class MockLocaleViewModel extends Mock implements LocaleViewModel {}

void main() {
  late FetchAllMoviesUseCase fetchAllMoviesUseCase;
  late MockFetchTopRatedMoviesUseCase mockTopRatedUseCase;
  late MockFetchNowPlayingMoviesUseCase mockNowPlayingUseCase;
  late MockFetchUpcomingMoviesUseCase mockUpcomingUseCase;
  late MockLocaleViewModel mockLocaleViewModel;

  setUp(() {
    getIt.reset();
    mockTopRatedUseCase = MockFetchTopRatedMoviesUseCase();
    mockNowPlayingUseCase = MockFetchNowPlayingMoviesUseCase();
    mockUpcomingUseCase = MockFetchUpcomingMoviesUseCase();
    mockLocaleViewModel = MockLocaleViewModel();

    getIt.registerSingleton<LocaleViewModel>(mockLocaleViewModel);

    fetchAllMoviesUseCase = FetchAllMoviesUseCase(
      topRatedUseCase: mockTopRatedUseCase,
      nowPlayingUseCase: mockNowPlayingUseCase,
      upcomingUseCase: mockUpcomingUseCase,
    );
  });

  group('FetchMovieDetailsUseCase', () {
    test('returns MoviesResult when all use cases return data', () async {
      final topRated = MoviesModel(page: 1, movies: [], totalPages: 1, totalResults: 1);
      final nowPlaying = MoviesModel(page: 1, movies: [], totalPages: 1, totalResults: 1);
      final upcoming = MoviesModel(page: 1, movies: [], totalPages: 1, totalResults: 1);

      when(() => mockTopRatedUseCase()).thenAnswer((_) async => topRated);
      when(() => mockNowPlayingUseCase()).thenAnswer((_) async => nowPlaying);
      when(() => mockUpcomingUseCase()).thenAnswer((_) async => upcoming);

      final result = await fetchAllMoviesUseCase();

      expect(result, isA<MoviesResult>());
      expect(result!.topRated, topRated);
      expect(result.nowPlaying, nowPlaying);
      expect(result.upcoming, upcoming);

      verify(() => mockTopRatedUseCase()).called(1);
      verify(() => mockNowPlayingUseCase()).called(1);
      verify(() => mockUpcomingUseCase()).called(1);
    });

    test('returns null if any use case returns null', () async {
      when(() => mockTopRatedUseCase()).thenAnswer((_) async => null);
      when(() => mockNowPlayingUseCase()).thenAnswer((_) async => MoviesModel(page: 1, movies: [], totalPages: 1, totalResults: 1));
      when(() => mockUpcomingUseCase()).thenAnswer((_) async => MoviesModel(page: 1, movies: [], totalPages: 1, totalResults: 1));

      final result = await fetchAllMoviesUseCase();

      expect(result, isNull);

      verify(() => mockTopRatedUseCase()).called(1);
      verify(() => mockNowPlayingUseCase()).called(1);
      verify(() => mockUpcomingUseCase()).called(1);
    });
  });
}