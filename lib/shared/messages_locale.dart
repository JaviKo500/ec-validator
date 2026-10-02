import 'package:flutter/foundation.dart';

import 'package:ec_validations/ec_validations.dart';

/// Languages offered for the app texts and the validation messages.
const Map<String, String> messageLanguages = {
  'en': 'English',
  'es': 'Español',
  'pt': 'Português',
};

/// Locale code of the active `ec_validations` message catalog, which is also
/// the language of the app texts (see `AppStrings`).
final ValueNotifier<String> messagesLocale = ValueNotifier(
  EcValidationsL10n.messages.localeCode,
);

/// Selects the language for [code] and notifies listeners.
void useMessagesLocale(String code) {
  if (EcValidationsL10n.use(code)) {
    messagesLocale.value = EcValidationsL10n.messages.localeCode;
  }
}
