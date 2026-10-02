import 'package:flutter/material.dart';

import 'package:ec_validations/ec_validations.dart';

import 'package:ec_validator/shared/demo_result.dart';
import 'package:ec_validator/shared/mode_selector.dart';
import 'package:ec_validator/shared/validator_demo_page.dart';

/// Validation mode chosen in the form.
enum PhoneMode { any, local, international }

class PhoneValidatorPage extends StatefulWidget {
  const PhoneValidatorPage({super.key});

  @override
  State<PhoneValidatorPage> createState() => _PhoneValidatorPageState();
}

class _PhoneValidatorPageState extends State<PhoneValidatorPage> {
  PhoneMode phoneMode = PhoneMode.any;

  static const List<DemoMode<PhoneMode>> modes = [
    DemoMode(
      value: PhoneMode.any,
      label: 'Any',
      description:
          'Accepts local (0991234567) or international '
          '(+593991234567) notation.',
    ),
    DemoMode(
      value: PhoneMode.local,
      label: 'Local',
      description: 'Only local notation: 09 for mobile, 02–07 for landlines.',
    ),
    DemoMode(
      value: PhoneMode.international,
      label: 'International',
      description: 'Only international notation with the +593 country code.',
    ),
  ];

  static const List<String> phonesAny = [
    '0991234567',
    '099 123 4567',
    '+593991234567',
    '593991234567',
    '+593 (0)99 123 4567',
    '0891234567',
    '+1991234567',
    '09912345',
  ];

  static const List<String> phonesLocal = [
    '0991234567',
    '099 123 4567',
    '(099) 123-4567',
    '0891234567',
    '09912345',
    '+593991234567',
  ];

  static const List<String> phonesInternational = [
    '+593991234567',
    '00593991234567',
    '593991234567',
    '+593 (0)99 123 4567',
    '+593891234567',
    '+1991234567',
    '0991234567',
  ];

  /// Validates using the method that matches the selected mode.
  PhoneResult validate(String phoneNumber) {
    switch (phoneMode) {
      case PhoneMode.local:
        return PhoneValidator.isValidLocal(phoneNumber);
      case PhoneMode.international:
        return PhoneValidator.isValidInternational(phoneNumber);
      case PhoneMode.any:
        return PhoneValidator.isValid(phoneNumber);
    }
  }

  /// Dart call that matches the selected mode.
  String codeFor(String phoneNumber) {
    switch (phoneMode) {
      case PhoneMode.local:
        return 'PhoneValidator.isValidLocal($phoneNumber)';
      case PhoneMode.international:
        return 'PhoneValidator.isValidInternational($phoneNumber)';
      case PhoneMode.any:
        return 'PhoneValidator.isValid($phoneNumber)';
    }
  }

  /// Sample numbers shown for the selected mode.
  List<String> get phonesTest {
    switch (phoneMode) {
      case PhoneMode.local:
        return phonesLocal;
      case PhoneMode.international:
        return phonesInternational;
      case PhoneMode.any:
        return phonesAny;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValidatorDemoPage(
      title: 'Phone number',
      description:
          'Validates Ecuadorian mobile and landline numbers and '
          'returns them normalized.',
      icon: Icons.phone_outlined,
      inputLabel: 'Phone number',
      inputHint: '0991234567',
      keyboardType: TextInputType.phone,
      modeSelector: ModeSelector<PhoneMode>(
        label: 'Phone format',
        modes: modes,
        selected: phoneMode,
        onChanged: (value) => setState(() => phoneMode = value),
      ),
      validate: (value) => DemoResult.phone(validate(value)),
      codeFor: codeFor,
      examples: phonesTest,
      showNormalized: true,
    );
  }
}
