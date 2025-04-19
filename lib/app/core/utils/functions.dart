
import 'package:challenge_mobile_multi/app/core/constants/data.dart';

class Functions {
  static String createValidImageUrl(String path, String size) {
    return '${Data.appConfig.imageBaseUrl}$size$path';
  }
}