
import 'package:challenge_mobile_multi/app/core/constants/data.dart';
import 'package:challenge_mobile_multi/app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Functions {
  static String createValidImageUrl(String path, String size) {
    return '${Data.appConfig.imageBaseUrl}$size$path';
  }

  static Color colorAccordingToTheCertification(String certification) {
    switch (certification) {
      case '+18':
        return AppColors.black;
      case '+16':
        return AppColors.red;
      case '+14':
        return AppColors.orange;
      case '+12':
        return AppColors.yellow;
      case '+10':
        return AppColors.blue3;
      case 'L':
        return AppColors.green;
      default:
        return AppColors.pink;
    }
  }
}