import 'package:challenge_mobile_multi/app/di/injection.dart';
import 'package:challenge_mobile_multi/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final sharedPrefs = await SharedPreferences.getInstance();
  
  initDependencies(sharedPrefs);
  runApp(const MyApp());
}
