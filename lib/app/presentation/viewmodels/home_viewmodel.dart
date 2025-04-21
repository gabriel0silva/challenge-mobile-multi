import 'package:challenge_mobile_multi/app/core/init/app_initializer.dart';
import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';
import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/domain/entities/movies_result.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/auth_repository.dart';
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
  final AppInitializer _appInitializer = getIt<AppInitializer>();

  HomeState homeState = HomeState.initial;

  bool isLoadingMore = false;
  bool isLoadingData = false;

  late TabController tabController;

  final ScrollController scrollController = ScrollController();

  List<Movie> topRatedMovies = [];
  List<Movie> nowPlayingdMovies = [];
  List<Movie> upComingMovies = [];

  int nowPlayingdMoviesTotalPages = 0;
  int nowPlayingdMoviesCurrentPage = 1;
  bool get hasMoreItemsNowPlayingMovies => nowPlayingdMoviesCurrentPage >= nowPlayingdMoviesCurrentPage;

  int upcomingMoviesTotalPages = 0;
  int upcomingMoviesCurrentPage = 1;
  bool get hasMoreItemsUpcomingMovies => nowPlayingdMoviesCurrentPage >= nowPlayingdMoviesCurrentPage;

  int get actualIndexTabBar => tabController.index;

  final topRatedMoviesController = PageController(initialPage: 3);

  final translation = getIt<TranslationService>();

  String selectedValue = '';

  int _currentCarouselIndex = 3;
  int get currentCarouselIndex => _currentCarouselIndex;

  void updateCarouselIndex(int index) {
    _currentCarouselIndex = index;
    notifyListeners();
  }

  void _emitHomeState(HomeState newState) {
    homeState = newState;
    notifyListeners();
  }

  void _emitLoadMore(bool value) {
    isLoadingMore = value;
    notifyListeners();
  }

  void _emitLoadData(bool value) {
    isLoadingData = value;
    notifyListeners();
  }

  Future<void> _loadMore() async {
    if (actualIndexTabBar == 0) {
      _loadMoreNowPlayingMovies();
    } else {
      _loadMoreUpcomingMovies();
    }
  }

  Future<void> _loadMoreNowPlayingMovies() async {
    if (isLoadingMore || nowPlayingdMoviesCurrentPage >= nowPlayingdMoviesTotalPages) return;

    _emitLoadMore(true);

    nowPlayingdMoviesCurrentPage++;

    final result = await useCaseNowPlaying(page: nowPlayingdMoviesCurrentPage);

    if (result != null) {
      nowPlayingdMovies.addAll(result.movies);
      _emitLoadMore(false);
    }
  }

  Future<void> _loadMoreUpcomingMovies() async {
    if (isLoadingMore || upcomingMoviesCurrentPage >= upcomingMoviesTotalPages) return;

    _emitLoadMore(true);

    upcomingMoviesCurrentPage++;

    final result = await useCaseUpcoming(page: upcomingMoviesCurrentPage);

    if (result != null) {
      upComingMovies.addAll(result.movies);
      _emitLoadMore(false);
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

    const threshold = 0;

    if (maxScroll - currentScroll <= threshold && !isLoadingMore && hasMoreItemsNowPlayingMovies) {
      _loadMore();
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
      _emitHomeState(HomeState.success);
    } else {
      _emitHomeState(HomeState.failure);
    }
  }

  Future<void> reloadMovies() async {
    _emitHomeState(HomeState.loading);

    await _appInitializer.fetchApiConfigurations();

    final isSuccess = await _loadData();

    if (isSuccess) {
      _emitHomeState(HomeState.success);
    } else {
      _emitHomeState(HomeState.failure);
    }
  }

  Future<bool> _loadData() async {
    final moviesResult = await useCaseAllMovies();

    final isSuccess = fillOutMovieLists(moviesResult);

    return isSuccess;
  }

  Future<void> fetchNowPlayingMovies() async {
    _emitLoadData(true);
    final result = await useCaseNowPlaying();

    if (result != null) {
      nowPlayingdMoviesTotalPages = result.totalPages;
      nowPlayingdMovies = result.movies;
      upComingMovies.clear();
      _emitLoadData(false);
    } 
  }

  Future<void> fetchUpcomingMovies() async {
    _emitLoadData(true);
    final result = await useCaseUpcoming();

    if (result != null) {
      upcomingMoviesTotalPages = result.totalPages;
      upComingMovies = result.movies;
      nowPlayingdMovies.clear();
      _emitLoadData(false);
    } 
  }
 
  Future<void> changeLanguage(String value) async {
    _emitHomeState(HomeState.loading);

    final isSuccess = await _loadData();
    selectedValue = value;

    if (isSuccess) {
      _emitHomeState(HomeState.success);
    } else {
      _emitHomeState(HomeState.failure);
    }
  }

  bool fillOutMovieLists(MoviesResult? moviesResult) {
    if (moviesResult == null) return false;

    nowPlayingdMoviesTotalPages = moviesResult.nowPlaying.totalPages;
    upcomingMoviesTotalPages = moviesResult.upcoming.totalPages;

    topRatedMovies = moviesResult.topRated.movies;
    nowPlayingdMovies = moviesResult.nowPlaying.movies;
    upComingMovies = moviesResult.upcoming.movies;

    return true;
  }
}
