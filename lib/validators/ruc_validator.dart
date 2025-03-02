

import 'package:ec_validator/entities/index.dart';
import 'package:ec_validator/exceptions/index.dart';
import 'package:ec_validator/helpers/index.dart';

class RucValidator {
  
  static IdentificationResult validateRucByType(String ruc, TypeIdentification typeIdentification) {
    try {
      initValidate(ruc, typeIdentification);
      validateCodeProvince(ruc.substring(0, 2));
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
        errorMessage: 'Invalid ruc identification',
        typeCodeError: ErrorCode.invalidIdentification,
      );
    }
  }
}