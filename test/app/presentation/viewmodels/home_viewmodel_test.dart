import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';
import 'package:challenge_mobile_multi/app/domain/entities/movies_result.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_all_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_now_playing_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_upcoming_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/home_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:challenge_mobile_multi/app/services/translation_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

final getIt = GetIt.instance;

class MockFetchAllMoviesUseCase extends Mock implements FetchAllMoviesUseCase {}
class MockFetchNowPlayingMoviesUseCase extends Mock implements FetchNowPlayingMoviesUseCase {}
class MockFetchUpcomingMoviesUseCase extends Mock implements FetchUpcomingMoviesUseCase {}
class MockTranslationService extends Mock implements TranslationService {}
class MockLocaleViewModel extends Mock implements LocaleViewModel {}

void main() {
  late MockFetchAllMoviesUseCase mockAllMoviesUseCase;
  late MockFetchNowPlayingMoviesUseCase mockNowPlayingUseCase;
  late MockFetchUpcomingMoviesUseCase mockUpcomingUseCase;
  late MockTranslationService mockTranslationService;
  late MockLocaleViewModel mockLocaleViewModel;
  late HomeViewModel viewModel;

  setUpAll(() {
    mockAllMoviesUseCase = MockFetchAllMoviesUseCase();
    mockNowPlayingUseCase = MockFetchNowPlayingMoviesUseCase();
    mockUpcomingUseCase = MockFetchUpcomingMoviesUseCase();
    mockTranslationService = MockTranslationService();
    mockLocaleViewModel = MockLocaleViewModel();

    getIt.registerSingleton<TranslationService>(mockTranslationService);
    getIt.registerSingleton<LocaleViewModel>(mockLocaleViewModel);
  });

  tearDownAll(() {
    getIt.reset();
  });

  setUp(() {
    viewModel = HomeViewModel(
      useCaseAllMovies: mockAllMoviesUseCase,
      useCaseNowPlaying: mockNowPlayingUseCase,
      useCaseUpcoming: mockUpcomingUseCase,
    );
  });

  group('HomeViewModel', () {

    final movieResponseModel = MoviesModel(
      page: 1, 
      movies: [
        Movie(
          adult: false, 
          backdropPath: '', 
          genreIds: [], 
          id: 0, 
          originalLanguage: '', 
          originalTitle: '', 
          overview: '', 
          popularity: 0.0, 
          posterPath: '', 
          releaseDate: '', 
          title: '', 
          video: false, 
          voteAverage: 0.0, 
          voteCount: 1,
        ),
        Movie(
          adult: false, 
          backdropPath: '', 
          genreIds: [], 
          id: 0, 
          originalLanguage: '', 
          originalTitle: '', 
          overview: '', 
          popularity: 0.0, 
          posterPath: '', 
          releaseDate: '', 
          title: '', 
          video: false, 
          voteAverage: 0.0, 
          voteCount: 1,
        )
      ], 
      totalPages: 2, 
      totalResults: 2,
    );

    test('updateCarouselIndex should change current index and notify listeners', () {
      var notified = false;
      viewModel.addListener(() => notified = true);

      viewModel.updateCarouselIndex(5);

      expect(viewModel.currentCarouselIndex, 5);
      expect(notified, true);
    });

    test('changeLanguage should call _loadData and update selectedValue', () async {
      final mockMoviesResult = MoviesResult(
        nowPlaying: movieResponseModel,
        upcoming: movieResponseModel,
        topRated: movieResponseModel,
      );

      when(() => mockAllMoviesUseCase()).thenAnswer((_) async => mockMoviesResult);

      viewModel.selectedValue = '';

      await viewModel.changeLanguage('english');

      expect(viewModel.selectedValue, 'english');
      expect(viewModel.nowPlayingdMovies, isNotEmpty);
      expect(viewModel.upComingMovies, isNotEmpty);
      expect(viewModel.topRatedMovies, isNotEmpty);
    });

    test('fetchNowPlayingMovies should load and populate nowPlaying list', () async {
      final result = movieResponseModel;

      when(() => mockNowPlayingUseCase()).thenAnswer((_) async => result);

      await viewModel.fetchNowPlayingMovies();

      expect(viewModel.nowPlayingdMoviesTotalPages, 2);
      expect(viewModel.nowPlayingdMovies.length, 2);
    });

    test('fetchUpcomingMovies should load and populate upcoming list', () async {
      final result = movieResponseModel;

      when(() => mockUpcomingUseCase()).thenAnswer((_) async => result);

      await viewModel.fetchUpcomingMovies();

      expect(viewModel.upcomingMoviesTotalPages, 2);
      expect(viewModel.upComingMovies.length, 2);
    });

    test('_fillOutMovieLists returns false if result is null', () {
      final result = viewModel.fillOutMovieLists(null);
      expect(result, false);
    });

    test('_fillOutMovieLists returns true and fills lists', () {
      final mockMoviesResult = MoviesResult(
        nowPlaying: movieResponseModel,
        upcoming: movieResponseModel,
        topRated: movieResponseModel,
      );

      final result = viewModel.fillOutMovieLists(mockMoviesResult);

      expect(result, true);
      expect(viewModel.nowPlayingdMovies.length, 2);
      expect(viewModel.upComingMovies.length, 2);
      expect(viewModel.topRatedMovies.length, 2);
    });
  });
}