import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/core/extensions/extencion_double.dart';
import 'package:challenge_mobile_multi/app/core/extensions/extencion_string.dart';
import 'package:challenge_mobile_multi/app/core/utils/functions.dart';
import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';
import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/movies_repository.dart';
import 'package:challenge_mobile_multi/app/presentation/states/home_state.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:challenge_mobile_multi/app/services/translation_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final MoviesRepository repository;

  HomeViewModel({required this.repository});

  final LocaleViewModel localeViewModel = getIt<LocaleViewModel>();

  HomeState state = HomeState.initial;


  List<Movie> topRatedMovies = [];
  List<Movie> nowPlayingdMovies = [];
  List<Movie> upComingMovies = [];

  int nowPlayingdMoviesTotalPages = 0;
  int nowPlayingdMoviesCurrentPage = 0;

  final topRatedMoviesController = PageController(initialPage: 3);

  final translation = getIt<TranslationService>();

  String selectedValue = '';

  int _currentCarouselIndex = 3;
  int get currentCarouselIndex => _currentCarouselIndex;

  void updateCarouselIndex(int index) {
    _currentCarouselIndex = index;
    notifyListeners();
  }

  void emitState(HomeState newState) {
    state = newState;
    notifyListeners();
  }

  Future<void> init() async {
    try {
      selectedValue = translation.translate('portuguese');

      final isSuccess = await _loadData();

      if (isSuccess) {
        emitState(HomeState.success);
      } else {
        emitState(HomeState.failure);
      }
      
    } catch (e) {
      emitState(HomeState.failure);
      debugPrint('Error loading movies: $e');
    }
  }

  Future<bool> _loadData() async {
    final topRatedMoviesData = await _fetchTopRatedMovies();
    final nowPlayingMoviesData = await _fetchNowPlayingMovies();
    final upComingMoviesData = await _fetchUpComingMovies();

    final isSuccess = _fillOutMovieLists(topRatedMoviesData, nowPlayingMoviesData, upComingMoviesData);

    return isSuccess;
  }
 
  Future<void> changeLanguage(String value) async {
    emitState(HomeState.loading);

    final isSuccess = await _loadData();
    selectedValue = value;

    if (isSuccess) {
      emitState(HomeState.success);
    } else {
      emitState(HomeState.failure);
    }
  }

  Future<MoviesModel?> _fetchTopRatedMovies() async {
    return await repository.fetchTopRatedMovies();
  }

  Future<MoviesModel?> _fetchNowPlayingMovies() async {
    return await repository.fetchNowPlayingMovies();
  }

  Future<MoviesModel?> _fetchUpComingMovies() async {
    return await repository.fetchUpComingMovies(page: 3);
  }

  bool _fillOutMovieLists(MoviesModel? topRatedData, MoviesModel? nowPlayingData, MoviesModel? upcomingData) {
    if (topRatedData != null && nowPlayingData != null && upcomingData != null) {
      topRatedMovies = _formatMovieList(topRatedData.movies);
      nowPlayingdMovies = _formatMovieList(nowPlayingData.movies);
      upComingMovies = _formatMovieList(upcomingData.movies);

      return true;
    }

    return false;
  }

  List<Movie> _formatMovieList(List<Movie> movies) {
    return movies.map((movie) => _formatMovie(movie)).toList();
  }

  Movie _formatMovie(Movie movie) {
    movie.releaseDate = localeViewModel.locale.languageCode == 'pt' ? movie.releaseDate.toBrazilianDateFormat() : movie.releaseDate.toUSDateFormat();
    movie.popularity = movie.popularity.toOneDecimalDouble();
    movie.voteAverage = movie.voteAverage.toOneDecimalDouble();
    movie.backdropPath = Functions.createValidImageUrl(movie.backdropPath, Data.appConfig.imageSizes.backdrop.original);
    movie.posterPath = Functions.createValidImageUrl(movie.posterPath, Data.appConfig.imageSizes.poster.original);

    return movie;
  }
}
