import 'package:challenge_mobile_multi/app/core/init/app_initializer.dart';
import 'package:challenge_mobile_multi/app/data/repositories/auth_repository_impl.dart';
import 'package:challenge_mobile_multi/app/data/repositories/movies_repository_impl.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/auth_repository.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/movies_repository.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_movie_details_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_all_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_now_playing_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_top_rated_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_upcoming_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/details_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/home_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/splash_screen_viewmodel.dart';
import 'package:challenge_mobile_multi/app/services/dio_service.dart';
import 'package:challenge_mobile_multi/app/services/token_storage_service.dart';
import 'package:challenge_mobile_multi/app/services/translation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void initDependencies(SharedPreferences sharedPrefs) {
  getIt.registerLazySingleton<DioService>(() => DioService());
  getIt.registerLazySingleton<TokenStorageService>(() => TokenStorageService(sharedPrefs));
  getIt.registerLazySingleton(() => LocaleViewModel());
  getIt.registerSingleton<TranslationService>(TranslationService());
  getIt.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl(getIt<DioService>(),));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<DioService>(),
      getIt<TokenStorageService>(),
    ),
  );
  getIt.registerLazySingleton(() => AppInitializer(getIt<AuthRepository>()));
  getIt.registerFactory(() => SplashScreenViewModel(
    initializer: getIt(),
    homeViewModel: getIt(),
  ));
  getIt.registerLazySingleton(() => FetchMovieDetailsUseCase(getIt<MoviesRepository>()));
  getIt.registerLazySingleton(() => FetchTopRatedMoviesUseCase(getIt<MoviesRepository>()));
  getIt.registerLazySingleton(() => FetchNowPlayingMoviesUseCase(getIt<MoviesRepository>()));
  getIt.registerLazySingleton(() => FetchUpcomingMoviesUseCase(getIt<MoviesRepository>()));
  getIt.registerLazySingleton(() => FetchAllMoviesUseCase(
    topRatedUseCase: getIt<FetchTopRatedMoviesUseCase>(),
    nowPlayingUseCase: getIt<FetchNowPlayingMoviesUseCase>(),
    upcomingUseCase: getIt<FetchUpcomingMoviesUseCase>(),
  ));
  getIt.registerLazySingleton(() => HomeViewModel(
    useCaseAllMovies: getIt<FetchAllMoviesUseCase>(),
    useCaseNowPlaying: getIt<FetchNowPlayingMoviesUseCase>(),
    useCaseUpcoming: getIt<FetchUpcomingMoviesUseCase>(),
  ));
  getIt.registerLazySingleton(() => DetailsViewModel(getIt<FetchMovieDetailsUseCase>()));
}
