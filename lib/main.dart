import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:ec_validations/ec_validations.dart';

import 'package:ec_validator/l10n.dart';
import 'package:ec_validator/shared/app_shell.dart';
import 'package:ec_validator/shared/app_strings.dart';
import 'package:ec_validator/shared/app_theme.dart';
import 'package:ec_validator/shared/messages_locale.dart';

void main() {
  // English and Spanish ship with the package; Portuguese is a custom catalog.
  EcValidationsL10n.register(EcMessagesPt());
  // Start in the browser language when it is one of the supported ones.
  useMessagesLocale(PlatformDispatcher.instance.locale.languageCode);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStringsScope(
      child: Builder(
        builder: (context) => MaterialApp(
          title: AppStrings.of(context).appTitle,
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(Brightness.light),
          darkTheme: buildAppTheme(Brightness.dark),
          locale: Locale(messagesLocale.value),
          supportedLocales: messageLanguages.keys.map(Locale.new),
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          home: const AppShell(),
        ),
      ),
    );
  }
}
