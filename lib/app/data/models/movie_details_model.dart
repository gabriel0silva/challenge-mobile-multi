class MovieDetailsModel {
  final String backdropPath;
  final int budget;
  String? budgetformatted;
  final List<Genre> genres;
  String? formattedGenres;
  final List<String> originCountries;
  String? originCountry;
  final String originalTitle;
  final String overview;
  final String posterPath;
  String releaseDate;
  String? yearReleaseDate;
  final String title;
  final bool video;
  double voteAverage;
  final int voteCount;
  final String certification;

  MovieDetailsModel({
    required this.backdropPath,
    required this.budget,
    this.budgetformatted,
    required this.genres,
    this.formattedGenres, 
    required this.originCountries,
    this.originCountry,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    this.yearReleaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.certification,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json, String certification) {
    return MovieDetailsModel(
      backdropPath: json['backdrop_path'] ?? '',
      budget: json['budget'] ?? 0,
      genres: (json['genres'] as List<dynamic>)
          .map((genre) => Genre.fromJson(genre))
          .toList(),
      originCountries: List<String>.from(json['origin_country'] ?? []),
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      certification: certification,
    );
  }

  MovieDetailsModel copyWith({
    String? backdropPath,
    int? budget,
    String? budgetformatted,
    List<Genre>? genres,
    String? formattedGenres,
    List<String>? originCountries,
    String? originCountry,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? releaseDate,
    String? yearReleaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
    String? certification,
  }) {
    return MovieDetailsModel(
      backdropPath: backdropPath ?? this.backdropPath,
      budget: budget ?? this.budget,
      budgetformatted: budgetformatted ?? this.budgetformatted,
      genres: genres ?? this.genres,
      formattedGenres: formattedGenres ?? this.formattedGenres,
      originCountries: originCountries ?? this.originCountries,
      originCountry: originCountry ?? this.originCountry,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      yearReleaseDate: yearReleaseDate ?? this.yearReleaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      certification: certification ?? this.certification,
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}
