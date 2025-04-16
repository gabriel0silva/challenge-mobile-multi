import 'package:challenge_mobile_multi/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LocaleViewModel extends ChangeNotifier {
  Locale _locale = const Locale('pt');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.supportedLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
}
