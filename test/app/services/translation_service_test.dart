import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:challenge_mobile_multi/app/services/translation_service.dart';
import 'package:challenge_mobile_multi/l10n/app_localizations.dart';

class MockAppLocalizations extends Mock implements AppLocalizations {}

void main() {
  late TranslationService translationService;
  late MockAppLocalizations mockAppLocalizations;

  setUp(() {
    translationService = TranslationService();
    mockAppLocalizations = MockAppLocalizations();

    when(() => mockAppLocalizations.translate(any())).thenAnswer((invocation) => 'translation of "${invocation.positionalArguments.first}"');

    translationService.load(mockAppLocalizations);
  });

  group(
    'TranslationService', 
    () {
      test('must return the translation of a valid key', () {
        final result = translationService.translate('hello');
        expect(result, 'tradução de "hello"');
      });

      test('should return the translation of an invalid (handled) key', () {
        final result = translationService.translate('invalid_key');
        expect(result, 'tradução de "invalid_key"');
      });

      test('must call the translate method of AppLocalizations with the correct key', () {
        translationService.translate('test_key');
        verify(() => mockAppLocalizations.translate('test_key')).called(1);
      });
    },
  );
}
