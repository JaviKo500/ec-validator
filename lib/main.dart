import 'package:flutter/material.dart';

import 'package:ec_validations/ec_validations.dart';

import 'package:ec_validator/l10n.dart';
import 'package:ec_validator/shared/app_shell.dart';
import 'package:ec_validator/shared/app_theme.dart';

void main() {
  // English and Spanish ship with the package; Portuguese is a custom catalog.
  EcValidationsL10n.register(EcMessagesPt());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ec_validations demo',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(Brightness.light),
      darkTheme: buildAppTheme(Brightness.dark),
      home: const AppShell(),
    );
  }
}
