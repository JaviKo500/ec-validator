import 'package:flutter/material.dart';

import 'package:ec_validations/ec_validations.dart';

import 'package:ec_validator/shared/demo_result.dart';
import 'package:ec_validator/shared/mode_selector.dart';
import 'package:ec_validator/shared/validator_demo_page.dart';

class RucValidatorPage extends StatefulWidget {
  const RucValidatorPage({super.key});

  @override
  State<RucValidatorPage> createState() => _RucValidatorPageState();
}

class _RucValidatorPageState extends State<RucValidatorPage> {
  TypeIdentification typeIdentification = TypeIdentification.ruc;

  static const List<DemoMode<TypeIdentification>> modes = [
    DemoMode(
      value: TypeIdentification.ruc,
      label: 'Any type',
      description:
          'Accepts a RUC of a natural person, private company or '
          'public entity.',
    ),
    DemoMode(
      value: TypeIdentification.rucPersonNatural,
      label: 'Natural person',
      description:
          'Third digit 0–5: an ID card number followed by the '
          'establishment code.',
    ),
    DemoMode(
      value: TypeIdentification.rucSocietyPrivate,
      label: 'Private company',
      description: 'Third digit 9, modulo 11 check digit.',
    ),
    DemoMode(
      value: TypeIdentification.rucPublicSociety,
      label: 'Public entity',
      description:
          'Third digit 6, modulo 11 check digit on the first 8 '
          'digits.',
    ),
    DemoMode(
      value: TypeIdentification.possiblyValidRuc,
      label: 'Quick check',
      description:
          'Checks only the length and the province code, without '
          'the check digit.',
    ),
  ];

  static const List<String> identifications = [
    '0105566046001',
    '0105566046000',
    '3095566046001',
    '95566046001',
    '0105566039001',
  ];

  static const List<String> identificationsPrivate = [
    '0992256230001',
    '1790011674001',
    '09A2256230001',
    '3092256230001',
    '0992256230000',
    '0982256230001',
    '1790450635001',
    '0992256234001',
  ];

  static const List<String> identificationsPublic = [
    '1760004650001',
    '1760001120001',
    '1760001120000',
    '1770001120001',
    '3060001120001',
    '17600011200',
    '1760004680001',
  ];

  static const List<String> listRuc = [
    '0105566046001',
    '1760004650001',
    '0992256230001',
    '0105566001',
    '1760004611001',
    '0992256223001',
  ];

  /// Validates using the method that matches the selected type.
  IdentificationResult validate(String ruc) {
    switch (typeIdentification) {
      case TypeIdentification.possiblyValidRuc:
        return RucValidator.isPossiblyValidRuc(ruc);
      case TypeIdentification.ruc:
        return RucValidator.validateRuc(ruc);
      default:
        return RucValidator.validateRucByType(ruc, typeIdentification);
    }
  }

  /// Dart call that matches the selected type.
  String codeFor(String ruc) {
    switch (typeIdentification) {
      case TypeIdentification.possiblyValidRuc:
        return 'RucValidator.isPossiblyValidRuc($ruc)';
      case TypeIdentification.ruc:
        return 'RucValidator.validateRuc($ruc)';
      default:
        return 'RucValidator.validateRucByType(\n  $ruc,\n'
            '  TypeIdentification.${typeIdentification.name},\n)';
    }
  }

  /// Sample RUC numbers shown for the selected type.
  List<String> get listRucTest {
    switch (typeIdentification) {
      case TypeIdentification.rucPersonNatural:
        return identifications;
      case TypeIdentification.rucSocietyPrivate:
        return identificationsPrivate;
      case TypeIdentification.rucPublicSociety:
      case TypeIdentification.possiblyValidRuc:
        return identificationsPublic;
      default:
        return listRuc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValidatorDemoPage(
      title: 'RUC',
      description:
          'Validates the 13-digit taxpayer number (Registro Único de '
          'Contribuyentes) by type.',
      icon: Icons.business_outlined,
      inputLabel: 'RUC number',
      inputHint: '0105566046001',
      keyboardType: TextInputType.number,
      modeSelector: ModeSelector<TypeIdentification>(
        label: 'RUC type',
        modes: modes,
        selected: typeIdentification,
        onChanged: (value) => setState(() => typeIdentification = value),
      ),
      validate: (value) => DemoResult.identification(validate(value)),
      codeFor: codeFor,
      examples: listRucTest,
    );
  }
}
