import 'package:ec_validator/entities/index.dart';
import 'package:ec_validator/exceptions/index.dart';
import 'package:ec_validator/helpers/index.dart';

class DniValidator {
  static IdentificationResult isValid(String identification) {
    try {
      initValidate(identification, TypeIdentification.dni);
      validateCodeProvince(identification.substring(0, 2));
      validateThirdDigit(identification.substring(2, 3), TypeIdentification.dni);
      algorithm10(identification.substring(0, 9), identification.substring(9, 10));
      return IdentificationResult(
        isValid: true,
        errorMessage: null,
        typeCodeError: null,
      );
    } catch (e) {
      if (e is IdentificationException) {
        return IdentificationResult(
          isValid: false,
          errorMessage: e.message,
          typeCodeError: e.code,
        );  
      }
      return IdentificationResult(
        isValid: false,
        errorMessage: 'Invalid identification',
        typeCodeError: ErrorCode.invalidIdentification,
      );
    }
  }
}