import 'package:challenge_mobile_multi/app/core/constants/poster_sizes.dart';

class AppConfig {
  String imageBaseUrl;
  ImageSizes imageSizes;

  AppConfig({
    required this.imageBaseUrl,
    required this.imageSizes,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      imageBaseUrl: json['images']['secure_base_url'] ?? '',
      imageSizes: ImageSizes.fromJson(json),
    );
  }
}