import 'package:flutter/material.dart';

import 'package:ec_validations/ec_validations.dart';

import 'package:ec_validator/shared/app_strings.dart';
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

  List<DemoMode<TypeIdentification>> modes(AppStrings strings) => [
    DemoMode(
      value: TypeIdentification.ruc,
      label: strings.rucAnyLabel,
      description: strings.rucAnyDescription,
    ),
    DemoMode(
      value: TypeIdentification.rucPersonNatural,
      label: strings.rucNaturalLabel,
      description: strings.rucNaturalDescription,
    ),
    DemoMode(
      value: TypeIdentification.rucSocietyPrivate,
      label: strings.rucPrivateLabel,
      description: strings.rucPrivateDescription,
    ),
    DemoMode(
      value: TypeIdentification.rucPublicSociety,
      label: strings.rucPublicLabel,
      description: strings.rucPublicDescription,
    ),
    DemoMode(
      value: TypeIdentification.possiblyValidRuc,
      label: strings.rucQuickLabel,
      description: strings.rucQuickDescription,
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
    final strings = AppStrings.of(context);

    return ValidatorDemoPage(
      title: strings.rucTitle,
      description: strings.rucDescription,
      icon: Icons.business_outlined,
      inputLabel: strings.rucInputLabel,
      inputHint: '0105566046001',
      keyboardType: TextInputType.number,
      modeSelector: ModeSelector<TypeIdentification>(
        label: strings.rucTypeLabel,
        modes: modes(strings),
        selected: typeIdentification,
        onChanged: (value) => setState(() => typeIdentification = value),
      ),
      validate: (value) => DemoResult.identification(validate(value)),
      codeFor: codeFor,
      examples: listRucTest,
    );
  }
}
