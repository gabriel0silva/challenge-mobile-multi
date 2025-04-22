import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/core/extensions/extencion_string.dart';
import 'package:challenge_mobile_multi/app/core/extensions/extension_double.dart';
import 'package:challenge_mobile_multi/app/core/utils/functions.dart';
import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';
import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/movies_repository.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:flutter/material.dart';

class FetchTopRatedMoviesUseCase {
  final MoviesRepository repository;

  FetchTopRatedMoviesUseCase(this.repository);

  final LocaleViewModel localeViewModel = getIt<LocaleViewModel>();

  Future<MoviesModel?> call() async {
    try {
      final response = await repository.fetchTopRatedMovies();
      if (response == null) return null;

      return _format(response);
    } catch (e) {
      debugPrint('Error in FetchTopRatedMoviesUseCase() -> $e');
      return null;
    }
  }

  MoviesModel _format(MoviesModel moviesData) {
    final formattedMovies = moviesData.movies.map((movie) {
      return movie.copyWith(
        releaseDate: localeViewModel.locale.languageCode == 'pt' ? movie.releaseDate.toBrazilianDateFormat() : movie.releaseDate.toUSDateFormat(),
        popularity: movie.popularity.toOneDecimalDouble(),
        voteAverage: movie.voteAverage.toOneDecimalDouble(),
        backdropPath: Functions.createValidImageUrl(
          movie.backdropPath,
          Data.appConfig.imageSizes!.backdrop.original,
        ),
        posterPath: Functions.createValidImageUrl(
          movie.posterPath,
          Data.appConfig.imageSizes!.poster.original,
        ),
      );
    }).toList();

    return moviesData.copyWith(movies: formattedMovies);
  }
}
