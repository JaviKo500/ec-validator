import 'package:flutter/material.dart';

import 'package:ec_validations/ec_validations.dart';

import 'package:ec_validator/shared/demo_result.dart';
import 'package:ec_validator/shared/validator_demo_page.dart';

class DniValidatorPage extends StatelessWidget {
  const DniValidatorPage({super.key});

  static const List<String> identifications = [
    '0105566046',
    '0105566039',
    '0195566046',
    '01A5566046',
    '3212121212',
    '2712121212',
    '010556604',
  ];

  @override
  Widget build(BuildContext context) {
    return ValidatorDemoPage(
      title: 'ID card (cédula)',
      description:
          'Validates the 10-digit Ecuadorian ID: province code, '
          'third digit and modulo 10 check digit.',
      icon: Icons.badge_outlined,
      inputLabel: 'ID number',
      inputHint: '0105566046',
      keyboardType: TextInputType.number,
      validate: (value) =>
          DemoResult.identification(DniValidator.isValid(value)),
      codeFor: (value) => 'DniValidator.isValid($value)',
      examples: identifications,
    );
  }
}
