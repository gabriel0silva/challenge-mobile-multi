import 'package:challenge_mobile_multi/l10n/app_localizations.dart';

class TranslationService {
  late AppLocalizations _l10n;

  void load(AppLocalizations l10n) {
    _l10n = l10n;
  }

  String translate(String key) {
    return _l10n.translate(key);
  }
}
