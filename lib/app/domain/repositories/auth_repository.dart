import 'package:challenge_mobile_multi/app/core/constants/app_config.dart';

abstract class AuthRepository {
  Future<AppConfig?> fetchApiConfigurations();
}