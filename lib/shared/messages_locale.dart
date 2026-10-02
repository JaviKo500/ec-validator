import 'package:flutter/foundation.dart';

import 'package:ec_validations/ec_validations.dart';

/// Languages offered for the validation messages.
const Map<String, String> messageLanguages = {
  'en': 'English',
  'es': 'Español',
  'pt': 'Português',
};

/// Locale code of the active `ec_validations` message catalog.
///
/// Pages listen to it to rebuild their messages when the language changes.
final ValueNotifier<String> messagesLocale = ValueNotifier(
  EcValidationsL10n.messages.localeCode,
);

/// Selects the message catalog for [code] and notifies listeners.
void useMessagesLocale(String code) {
  if (EcValidationsL10n.use(code)) {
    messagesLocale.value = EcValidationsL10n.messages.localeCode;
  }
}
