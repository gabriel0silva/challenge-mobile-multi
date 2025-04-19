import 'package:challenge_mobile_multi/app/data/models/movie_details_model.dart';
import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';

abstract interface class MoviesRepository {
  Future<MoviesModel?> fetchTopRatedMovies();
  Future<MoviesModel?> fetchUpComingMovies({int page = 1});
  Future<MoviesModel?> fetchNowPlayingMovies({int page = 1});
  Future<MovieDetailsModel?> fetchDetailsMovie({required int movieId});
}