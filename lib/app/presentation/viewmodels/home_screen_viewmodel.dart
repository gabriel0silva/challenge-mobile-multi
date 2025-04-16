import 'package:challenge_mobile_multi/app/presentation/states/home_state.dart';
import 'package:flutter/material.dart';

class HomeScreenViewmodel extends ChangeNotifier {

  HomeState state = HomeState.initial;

  Locale _locale = const Locale('pt');
  Locale get locale => _locale;

  void emitState(HomeState state) {
    state = state;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 1));
    emitState(HomeState.success);
  } 
}