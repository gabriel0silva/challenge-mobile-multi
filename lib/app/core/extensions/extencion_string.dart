extension ExtencionString on String {
  /// Converte de "yyyy-MM-dd" para "dd/MM/yyyy"
  String toBrazilianDateFormat() {
    try {
      final parts = split('-');
      if (parts.length != 3) return this;

      final year = parts[0];
      final month = parts[1];
      final day = parts[2];

      return '$day/$month/$year';
    } catch (_) {
      return this;
    }
  }

  /// Converte de "yyyy-MM-dd" para "MM/dd/yyyy"
  String toUSDateFormat() {
    try {
      final parts = split('-');
      if (parts.length != 3) return this;

      final year = parts[0];
      final month = parts[1];
      final day = parts[2];

      return '$month/$day/$year';
    } catch (_) {
      return this;
    }
  }
}