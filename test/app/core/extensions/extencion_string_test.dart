import 'package:challenge_mobile_multi/app/core/extensions/extencion_string.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validação das extensões para String - toBrazilianDateFormat()', () {
    test('Deve converter data corretamente para o formato brasileiro', () {
      expect('2024-12-25'.toBrazilianDateFormat(), '25/12/2024');
    });

    test('Deve retornar a string original se o formato estiver incorreto', () {
      expect('2024/12/25'.toBrazilianDateFormat(), '2024/12/25');
      expect(''.toBrazilianDateFormat(), '');
      expect('2024-12'.toBrazilianDateFormat(), '2024-12');
    });
  });

  group('Validação das extensões para String - toBrazilianDateFormat()', () {
    test('Deve converter data corretamente para o formato americano', () {
      expect('2024-12-25'.toUSDateFormat(), '12/25/2024');
    });

    test('Deve retornar a string original se o formato estiver incorreto', () {
      expect('2024/12/25'.toUSDateFormat(), '2024/12/25');
      expect(''.toUSDateFormat(), '');
      expect('2024-12'.toUSDateFormat(), '2024-12');
    });
  });
}
