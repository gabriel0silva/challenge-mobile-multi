import 'package:challenge_mobile_multi/app/core/constants/app_config.dart';
import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:challenge_mobile_multi/app/core/utils/functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Functions tests', () {
    test('createValidImageUrl returns correct URL', () {
      const path = '/image.jpg';
      const size = 'w500';
      Data.appConfig = AppConfig(imageBaseUrl: 'https://image.tmdb.org/t/p/');
      const expectedUrl = 'https://image.tmdb.org/t/p/$size$path';

      final result = Functions.createValidImageUrl(path, size);

      expect(result, expectedUrl);
    });

    test('colorAccordingToTheCertification returns correct color for +18', () {
      const certification = '+18';
      const expectedColor = AppColors.black;

      final result = Functions.colorAccordingToTheCertification(certification);

      expect(result, expectedColor);
    });

    test('colorAccordingToTheCertification returns correct color for +16', () {
      const certification = '+16';
      const expectedColor = AppColors.red;

      final result = Functions.colorAccordingToTheCertification(certification);

      expect(result, expectedColor);
    });

    test('colorAccordingToTheCertification returns default color for unknown certification', () {
      const certification = 'Unknown';
      const expectedColor = AppColors.pink;

      final result = Functions.colorAccordingToTheCertification(certification);

      expect(result, expectedColor);
    });
  });
}
