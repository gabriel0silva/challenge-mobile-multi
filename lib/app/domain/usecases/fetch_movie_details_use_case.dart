
import 'package:challenge_mobile_multi/app/core/constants/countries.dart';
import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/core/extensions/extencion_double.dart';
import 'package:challenge_mobile_multi/app/core/extensions/extencion_string.dart';
import 'package:challenge_mobile_multi/app/core/utils/functions.dart';
import 'package:challenge_mobile_multi/app/data/models/movie_details_model.dart';
import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/domain/repositories/movies_repository.dart';
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';

class FetchMovieDetailsUseCase {
  final MoviesRepository movieRepository;
  final LocaleViewModel localeViewModel = getIt<LocaleViewModel>();

  FetchMovieDetailsUseCase(this.movieRepository);

  Future<MovieDetailsModel?> call(int id) async {
    final movieDetails = await movieRepository.fetchDetailsMovie(movieId: id);

    if (movieDetails == null) return null;

    return _format(movieDetails);
  }

  MovieDetailsModel _format(MovieDetailsModel movieDetails) {
    final translatedCountries = movieDetails.originCountries.map((code) {
      return Countries.countries[code]?[localeViewModel.locale.languageCode] ?? Countries.countries[code]?['en'] ?? code;
    }).toList();

    final fullCountryName = translatedCountries.join(', ');

    return movieDetails.copyWith(
      originCountry: fullCountryName,
      backdropPath: Functions.createValidImageUrl(movieDetails.backdropPath, Data.appConfig.imageSizes.backdrop.original),
      budgetformatted: movieDetails.budget.toDouble().toCurrencyFormat(localeViewModel.locale),
      releaseDate: localeViewModel.locale.countryCode == 'pt' ? movieDetails.releaseDate.toBrazilianDateFormat() : movieDetails.releaseDate.toUSDateFormat(),
      yearReleaseDate: movieDetails.releaseDate.split('-').first,
      formattedGenres: '${movieDetails.genres.map((genre) => genre.name).join('; ')};',
    );
  }
}