
import 'package:challenge_mobile_multi/app/presentation/viewmodels/locale_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocaleViewModel extends Mock implements LocaleViewModel {}

void main() {
  group('LocaleViewModel', () {
    late LocaleViewModel localeViewModel;

    setUp(() {
      localeViewModel = LocaleViewModel();
    });

    test('should have pt as the initial locale', () {
      expect(localeViewModel.locale.languageCode, 'pt');
    });

    test('should set locale to en and notify listeners', () {
      localeViewModel.setLocale(const Locale('en'));

      expect(localeViewModel.locale.languageCode, 'en');
    });

    test('should not set unsupported locale', () {
      localeViewModel.setLocale(const Locale('es'));

      expect(localeViewModel.locale.languageCode, 'pt');
    });

    test('apiLanguageParam should return correct value for pt', () {
      expect(localeViewModel.apiLanguageParam, 'pt-BR');
    });

    test('apiLanguageParam should return correct value for en', () {
      localeViewModel.setLocale(const Locale('en'));

      expect(localeViewModel.apiLanguageParam, 'en-US');
    });
  });
}
