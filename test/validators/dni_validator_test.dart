import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validator/entities/index.dart';
import 'package:ec_validator/validators/index.dart';

void main() {
  group('Dni Validator Tests', () {
    test('Should return true if identification is valid', () {
      final result = DniValidator.isValid('0950064550');
      expect(result.isValid, true);
      expect(result.errorMessage, null);
      expect(result.typeCodeError, null);
    });

    test('should return invalid result for empty DNI', () {
      final result = DniValidator.isValid('');
      
      expect(result.isValid, isFalse);
      expect(result.errorMessage, 'Identification cannot be empty');
      expect(result.typeCodeError, ErrorCode.invalidEmpty);
    });

    test('should return invalid result for DNI with incorrect format', () {
      final result = DniValidator.isValid('123456789');
      
      expect(result.isValid, isFalse);
      expect(result.errorMessage, 'Invalid identification: must be exactly 10 digits and contain only numbers.');
      expect(result.typeCodeError, ErrorCode.invalidLengthOrFormat);
    });

    test('should return invalid result for DNI with invalid province code', () {
      final result = DniValidator.isValid('3105566046');
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidCodeProvince);
    });

    test('should return invalid result for DNI with invalid check digit', () {
      final result = DniValidator.isValid('0105566047');
      
      expect(result.isValid, isFalse);
      expect(result.typeCodeError, ErrorCode.invalidVerificationDigit);
    });
  });
}