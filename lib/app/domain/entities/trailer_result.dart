enum TrailerType {
  youtubeKey,
  youtubeUrl,
}

class TrailerResult {
  final TrailerType type;
  final String value;

  const TrailerResult({
    required this.type,
    required this.value,
  });
}