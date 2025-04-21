import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ExtencionDouble on double {

  // Retorna o número com 1 casas decimais como double
  double toOneDecimalDouble() {
    return double.parse(toStringAsFixed(1));
  }

  // Retorna o número formatado como moeda de acordo com a localidade
  String toCurrencyFormat(Locale locale) {
    final format = NumberFormat.simpleCurrency(locale: locale.toString());
    return format.format(this);
  }
}