import 'package:challenge_mobile_multi/app/data/models/movies_model.dart';

class MoviesResult {
  final MoviesModel topRated;
  final MoviesModel nowPlaying;
  final MoviesModel  upcoming;

  MoviesResult({
    required this.topRated,
    required this.nowPlaying,
    required this.upcoming,
  });
}