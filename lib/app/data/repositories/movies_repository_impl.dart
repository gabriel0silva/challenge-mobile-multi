import 'package:challenge_mobile_multi/app/data/models/movie_details_model.dart';
import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';
import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/domain/entities/trailer_result.dart';
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
  Future<MovieDetailsModel?> fetchDetailsMovie({required int movieId, required String movieTitle}) async {
    try {
      final movieResponse = await _dioService.get(
        '/movie/$movieId',
        queryParameters: {
          'language': localeViewModel.apiLanguageParam,
        },
      );

      final movieJson = movieResponse.data;

      if(movieJson == null) return null; 

      final certification = await _getCertification(movieId);
      final trailer = await _getTrailer(movieId: movieId, movieTitle: movieTitle);

      return MovieDetailsModel.fromJson(movieJson, certification, trailer);
    } catch (e) {
      debugPrint('Error in fetchDetailsMovie() => $e');
      return null;
    }
  }
  
  Future<TrailerResult> _getTrailer({required int movieId, required String movieTitle}) async {
    try {
      final response = await _dioService.get(
        '/movie/$movieId/videos',
        queryParameters: {
          'language': localeViewModel.apiLanguageParam,
        },
      );

      final results = response.data['results'] as List;

      if (results.isNotEmpty) {
        final trailer = results.firstWhere(
          (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube' && video['iso_639_1'] == localeViewModel.locale.languageCode,
          orElse: () => null,
        );

        if (trailer != null) {
          final key = trailer['key'];
          return TrailerResult(
            type: TrailerType.youtubeKey,
            value: key,
          );
        }
      }
      
      final query = Uri.encodeComponent('$movieTitle trailer');
      return TrailerResult(
        type: TrailerType.youtubeUrl,
        value: 'https://www.youtube.com/results?search_query=$query',
      );
    } catch (_) {
      final query = Uri.encodeComponent('$movieTitle trailer');
      return TrailerResult(
        type: TrailerType.youtubeUrl,
        value: 'https://www.youtube.com/results?search_query=$query',
      );
    }
  }

  Future<String> _getCertification(int movieId) async {
    try {
      final releaseResponse = await _dioService.get('/movie/$movieId/release_dates');
      final releaseDates = releaseResponse.data['results'] as List;

      const countryCode = 'BR';
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

        return releaseWithCert?['certification'] ?? '';
      }

      return '';
    } catch (e) {
      debugPrint('Error in _getCertification() => $e');
      return '';
    }
  }
}