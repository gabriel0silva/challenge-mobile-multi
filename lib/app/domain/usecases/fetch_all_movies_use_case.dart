import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/domain/entities/movies_result.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_now_playing_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_top_rated_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_upcoming_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';

class FetchAllMoviesUseCase {
  final FetchTopRatedMoviesUseCase topRatedUseCase;
  final FetchNowPlayingMoviesUseCase nowPlayingUseCase;
  final FetchUpcomingMoviesUseCase upcomingUseCase;
  
  final LocaleViewModel localeViewModel = getIt<LocaleViewModel>();

  FetchAllMoviesUseCase({
    required this.topRatedUseCase, 
    required this.nowPlayingUseCase, 
    required this.upcomingUseCase,
  });

  Future<MoviesResult?> call() async {
    final topRated = await topRatedUseCase();
    final nowPlaying = await nowPlayingUseCase();
    final upcoming = await upcomingUseCase();

    if (topRated == null || nowPlaying == null || upcoming == null) return null;

    return MoviesResult(
      topRated: topRated,
      nowPlaying: nowPlaying,
      upcoming: upcoming,
    );
  }
}