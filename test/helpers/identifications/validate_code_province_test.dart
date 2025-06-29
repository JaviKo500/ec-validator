import 'package:flutter_test/flutter_test.dart';

import 'package:ec_validator/exceptions/index.dart';
import 'package:ec_validator/entities/index.dart';
import 'package:ec_validator/helpers/index.dart';

void main() {
  group('Validate code province Tests', () {
    test('Should throw exception if code province is empty', () {
      expect( () {
        validateCodeProvince('');
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidCodeProvince
            && e.message == 'Invalid province code: the first two digits must be a number between 00 - 24 and 30 foreign.'
          )
        )
      ));
    });

    test('Should throw exception if code province is not a number', () {
      expect( () {
        validateCodeProvince('abc');
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidCodeProvince
            && e.message == 'Invalid province code: the first two digits must be a number between 00 - 24 and 30 foreign.'
          )
        )
      ));
    });

    test('Should throw exception if code province is less than 0', () {
      expect( () {
        validateCodeProvince('-1');
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidCodeProvince
            && e.message == 'Invalid province code: the first two digits must be a number between 00 - 24 and 30 foreign.'
          )
        )
      ));
    });

    test('Should throw exception if code province is greater than 24 and not 30', () {
      expect( () {
        validateCodeProvince('25');
      }, throwsA(
        allOf(
          isA<IdentificationException>(),
          predicate( (IdentificationException e) =>
            e.code == ErrorCode.invalidCodeProvince
            && e.message == 'Invalid province code: the first two digits must be a number between 00 - 24 and 30 foreign.'
          )
        )
      ));
    });

    test('Should not throw exception if code province is valid', () {
      expect( () {
        validateCodeProvince('00');
      }, returnsNormally);
    });
  });
}