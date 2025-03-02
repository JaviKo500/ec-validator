import 'package:ec_validator/entities/index.dart';
import 'package:ec_validator/exceptions/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IdentificationException Tests', () {
    test('Should create exception with code and message', () {
      const errorCode = ErrorCode.invalidType;
      const errorMessage = 'Invalid identification type';
      
      final exception = IdentificationException(errorCode, errorMessage);

      expect(exception.code, equals(errorCode));
      expect(exception.message, equals(errorMessage));
    });

    test('Should be catchable as Exception', () {
      const errorCode = ErrorCode.invalidType;
      const errorMessage = 'Invalid identification type';

      expect( () {
        throw IdentificationException(errorCode, errorMessage);
      }, throwsException);
    },);    
  });
}