import 'package:challenge_mobile_multi/app/domain/entities/trailer_result.dart';

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
  final TrailerResult trailer;
  final int voteCount;
  String certification;
  final String homepage;


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
    required this.trailer,
    required this.voteCount,
    required this.certification,
    required this.homepage,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json, String certification, TrailerResult trailer) {
    return MovieDetailsModel(
      backdropPath: json['backdrop_path'] ?? '',
      budget: json['budget'] ?? 0,
      genres: (json['genres'] as List<dynamic>).map((genre) => Genre.fromJson(genre)).toList(),
      originCountries: List<String>.from(json['origin_country'] ?? []),
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      trailer: trailer,
      voteCount: json['vote_count'] ?? 0,
      certification: certification,
      homepage: json['homepage'] ?? '',
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
    TrailerResult? trailer,
    int? voteCount,
    String? certification,
    String? homepage,
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
      trailer: trailer ?? this.trailer,
      voteCount: voteCount ?? this.voteCount,
      certification: certification ?? this.certification,
      homepage: homepage ?? this.homepage,
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
