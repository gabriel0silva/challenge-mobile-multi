import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';
import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/domain/entities/movies_result.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_all_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_now_playing_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/domain/usecases/fetch_upcoming_movies_use_case.dart';
import 'package:challenge_mobile_multi/app/presentation/states/home_state.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:challenge_mobile_multi/app/services/translation_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final FetchAllMoviesUseCase useCaseAllMovies;
  final FetchNowPlayingMoviesUseCase useCaseNowPlaying;
  final FetchUpcomingMoviesUseCase useCaseUpcoming;

  HomeViewModel({
    required this.useCaseAllMovies,
    required this.useCaseNowPlaying,
    required this.useCaseUpcoming,
  });

  final LocaleViewModel localeViewModel = getIt<LocaleViewModel>();

  HomeState homeState = HomeState.initial;

  bool isLoadingMore = false;

  late TabController tabController;

  final ScrollController scrollController = ScrollController();

  List<Movie> topRatedMovies = [];
  List<Movie> nowPlayingdMovies = [];
  List<Movie> upComingMovies = [];

  int nowPlayingdMoviesTotalPages = 0;
  int nowPlayingdMoviesCurrentPage = 1;
  bool get hasMoreItemsNowPlayingdMovies => nowPlayingdMoviesCurrentPage >= nowPlayingdMoviesCurrentPage;

  final topRatedMoviesController = PageController(initialPage: 3);

  final translation = getIt<TranslationService>();

  String selectedValue = '';

  int _currentCarouselIndex = 3;
  int get currentCarouselIndex => _currentCarouselIndex;

  void updateCarouselIndex(int index) {
    _currentCarouselIndex = index;
    notifyListeners();
  }

  void emitHomeState(HomeState newState) {
    homeState = newState;
    notifyListeners();
  }

  void emitLoadMore(bool value) {
    isLoadingMore = value;
    notifyListeners();
  }

  Future<void> _loadMoreNowPlayingMovies() async {
    if (isLoadingMore || nowPlayingdMoviesCurrentPage >= nowPlayingdMoviesTotalPages) return;

    emitLoadMore(true);

    nowPlayingdMoviesCurrentPage++;

    final result = await useCaseNowPlaying(page: nowPlayingdMoviesCurrentPage);

    if (result != null) {
      nowPlayingdMovies.addAll(result.movies);
      emitLoadMore(false);
    }
  }

  void _initAddListener() {
    scrollController.addListener(() {
      _onScroll();
    });
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    const threshold = 0; // distância do final pra começar a carregar

    if (maxScroll - currentScroll <= threshold && !isLoadingMore && hasMoreItemsNowPlayingdMovies) {
      _loadMoreNowPlayingMovies(); // sua função de carregar mais
    }
  }

  void initTabController(TickerProvider vsync) {
    tabController = TabController(
      length: 2,
      vsync: vsync,
    );
  }

  Future<void> init() async {
    selectedValue = translation.translate('portuguese');

    final isSuccess = await _loadData();

    if (isSuccess) {
      _initAddListener();
      emitHomeState(HomeState.success);
    } else {
      emitHomeState(HomeState.failure);
    }
  }

  Future<void> reloadMovies() async {
    try {
      emitHomeState(HomeState.loading);

      final isSuccess = await _loadData();

      if (isSuccess) {
        emitHomeState(HomeState.success);
      } else {
        emitHomeState(HomeState.failure);
      }
      
    } catch (e) {
      emitHomeState(HomeState.failure);
      debugPrint('Error reloadMovies() =>: $e');
    }
  }

  void _fillVariablesForPagination(MoviesModel movies) {

  }

  Future<bool> _loadData() async {
    final moviesResult = await useCaseAllMovies();

    final isSuccess = _fillOutMovieLists(moviesResult);

    return isSuccess;
  }
 
  Future<void> changeLanguage(String value) async {
    emitHomeState(HomeState.loading);

    final isSuccess = await _loadData();
    selectedValue = value;

    if (isSuccess) {
      emitHomeState(HomeState.success);
    } else {
      emitHomeState(HomeState.failure);
    }
  }

  bool _fillOutMovieLists(MoviesResult? moviesResult) {
    if (moviesResult == null) return false;

    nowPlayingdMoviesTotalPages = moviesResult.nowPlaying.totalPages;

    topRatedMovies = moviesResult.topRated.movies;
    nowPlayingdMovies = moviesResult.nowPlaying.movies;
    upComingMovies = moviesResult.upcoming.movies;

    return true;
  }
}
