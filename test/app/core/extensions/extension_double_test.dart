import 'package:challenge_mobile_multi/app/core/extensions/extension_double.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

void main() {
  group('ExtensionDouble', () {
    test(
      'toOneDecimalDouble() should return the number with 1 decimal place', 
      () {
        expect(10.456.toOneDecimalDouble(), 10.5);
        expect(3.14.toOneDecimalDouble(), 3.1);
        expect(0.01.toOneDecimalDouble(), 0.0);
      },
    );

    test('toCurrencyFormat should format correctly for pt_BR locale', () {
      const locale = Locale('pt', 'BR');
      const value = 1234.56;
      final formatted = value.toCurrencyFormat(locale);
      
      final expected = NumberFormat.simpleCurrency(locale: 'pt_BR').format(value);
      expect(formatted, expected);
    });

    test('toCurrencyFormat() should format correctly for en_US locale', () {
      const locale = Locale('en', 'US');
      const value = 1234.56;
      final formatted = value.toCurrencyFormat(locale);

      final expected = NumberFormat.simpleCurrency(locale: 'en_US').format(value);
      expect(formatted, expected);
    });
  });
}
