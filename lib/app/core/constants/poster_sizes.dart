class ImageSizes {
  final PosterSizes poster;
  final BackdropSizes backdrop;

  ImageSizes({
    required this.poster,
    required this.backdrop,
  });

  factory ImageSizes.fromJson(Map<String, dynamic> json) {
    return ImageSizes(
      poster: PosterSizes.fromList(json['images']['poster_sizes']),
      backdrop: BackdropSizes.fromList(json['images']['backdrop_sizes']),
    );
  }
}

class PosterSizes {
  final String w92;
  final String w154;
  final String w185;
  final String w342;
  final String w500;
  final String w780;
  final String original;

  PosterSizes({
    required this.w92,
    required this.w154,
    required this.w185,
    required this.w342,
    required this.w500,
    required this.w780,
    required this.original,
  });

  factory PosterSizes.fromList(List<dynamic> sizes) {
    return PosterSizes(
      w92: sizes.firstWhere((s) => s == 'w92', orElse: () => ''),
      w154: sizes.firstWhere((s) => s == 'w154', orElse: () => ''),
      w185: sizes.firstWhere((s) => s == 'w185', orElse: () => ''),
      w342: sizes.firstWhere((s) => s == 'w342', orElse: () => ''),
      w500: sizes.firstWhere((s) => s == 'w500', orElse: () => ''),
      w780: sizes.firstWhere((s) => s == 'w780', orElse: () => ''),
      original: sizes.firstWhere((s) => s == 'original', orElse: () => ''),
    );
  }
}

class BackdropSizes {
  final String w300;
  final String w780;
  final String w1280;
  final String original;

  BackdropSizes({
    required this.w300,
    required this.w780,
    required this.w1280,
    required this.original,
  });

  factory BackdropSizes.fromList(List<dynamic> sizes) {
    return BackdropSizes(
      w300: sizes.firstWhere((s) => s == 'w300', orElse: () => ''),
      w780: sizes.firstWhere((s) => s == 'w780', orElse: () => ''),
      w1280: sizes.firstWhere((s) => s == 'w1280', orElse: () => ''),
      original: sizes.firstWhere((s) => s == 'original', orElse: () => ''),
    );
  }
}