class MoviesModel {
  final int page;
  final List<Movie> movies;
  final int totalPages;
  final int totalResults;

  MoviesModel({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      page: json['page'],
      movies: (json['results'] as List).map((movie) => Movie.fromJson(movie)).toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}

class Movie {
  final bool adult;
  String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  final String title;
  final bool video;
  double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json['adult'],
      backdropPath: json['backdrop_path'] ?? '',
      genreIds: List<int>.from(json['genre_ids']),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
    );
  }
}
