import 'package:ec_validator/entities/index.dart';
import 'package:ec_validator/exceptions/index.dart';
import 'package:ec_validator/helpers/identification/init_validate.dart';

class DniValidator {
  static IdentificationResult isValid(String identification) {
    try {
      initValidate(identification, TypeIdentification.dni);
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