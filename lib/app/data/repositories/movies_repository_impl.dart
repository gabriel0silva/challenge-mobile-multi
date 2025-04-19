import 'package:challenge_mobile_multi/app/data/models/movie_details_model.dart';
import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';
import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/movies_repository.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:challenge_mobile_multi/app/services/dio_service.dart';
import 'package:flutter/widgets.dart';

class MoviesRepositoryImpl implements MoviesRepository{
  final DioService _dioService;
  final LocaleViewModel localeViewModel = getIt<LocaleViewModel>();

  MoviesRepositoryImpl(this._dioService);

  @override
  Future<MoviesModel?> fetchTopRatedMovies() async {
    try {
      final response = await _dioService.get(
        '/movie/top_rated',
        queryParameters: {
          'page': 1,
          'language': localeViewModel.apiLanguageParam,
        },
      );
      
      if (response.statusCode == 200 && response.data['results'] != null) {
        return MoviesModel.fromJson(response.data);
      }

      return null;
    } catch (e) {
      debugPrint('Error in fetchTopRatedMovies() => $e');
      return null;
    }
  }

  @override
  Future<MoviesModel?> fetchUpComingMovies({int page = 1}) async {
    try {
      final response = await _dioService.get(
        '/movie/upcoming',
        queryParameters: {
          'page': page,
          'language': localeViewModel.apiLanguageParam,
        },
      );
      
      if (response.statusCode == 200 && response.data['results'] != null) {
        return MoviesModel.fromJson(response.data);
      }

      return null;
    } catch (e) {
      debugPrint('Error in fetchUpComingMovies() => $e');
      return null;
    }
  }

  @override
  Future<MoviesModel?> fetchNowPlayingMovies({int page = 1}) async {
    try {
      final response = await _dioService.get(
        '/movie/now_playing',
        queryParameters: {
          'page': page,
          'language': localeViewModel.apiLanguageParam,
        },
      );
      
      if (response.statusCode == 200 && response.data['results'] != null) {
        return MoviesModel.fromJson(response.data);
      }

      return null;
    } catch (e) {
      debugPrint('Error in fetchUpComingMovies() => $e');
      return null;
    }
  }
  
  @override
  Future<MovieDetailsModel?> fetchDetailsMovie({required int movieId}) async {
    try {
      final movieResponse = await _dioService.get(
        '/movie/$movieId',
        queryParameters: {
          'language': localeViewModel.apiLanguageParam,
        },
      );

      final releaseResponse = await _dioService.get('/movie/$movieId/release_dates');
      
      final movieJson = movieResponse.data;
      final releaseDates = releaseResponse.data['results'] as List;

      final countryCode = localeViewModel.locale.languageCode.toUpperCase();
      String certification = '';

      final matchingCountry = releaseDates.firstWhere(
        (element) => element['iso_3166_1'] == countryCode,
        orElse: () => null,
      );

      if (matchingCountry != null && matchingCountry['release_dates'] != null) {
        final releaseList = matchingCountry['release_dates'] as List;

        final releaseWithCert = releaseList.firstWhere(
          (e) => (e['certification'] as String).isNotEmpty,
          orElse: () => null,
        );

        certification = releaseWithCert?['certification'] ?? '';
      }

      return MovieDetailsModel.fromJson(movieJson, certification);

    } catch (e) {
      debugPrint('Error in fetchDetailsMovie() => $e');
      return null;
    }
  }
}