

import 'package:ec_validator/entities/index.dart';
import 'package:ec_validator/exceptions/index.dart';
import 'package:ec_validator/helpers/index.dart';

class RucValidator {
  
  static IdentificationResult isPossiblyValidRuc(String ruc) {
    try {
      initValidate(ruc, TypeIdentification.rucPersonNatural);
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

  static IdentificationResult validateRucByType(String ruc, TypeIdentification typeIdentification) {
    try {
      initValidate(ruc, typeIdentification);
      validateCodeProvince(ruc.substring(0, 2));
      switch (typeIdentification) {
        case TypeIdentification.rucPersonNatural:
          validateThirdDigit(ruc.substring(2, 3), typeIdentification);
          validateCodeEstablishment(ruc.substring(10, 13));
          algorithm10(ruc.substring(0, 9), ruc.substring(9, 10));
          break;
        case TypeIdentification.rucSocietyPrivate:
          validateThirdDigit(ruc.substring(2, 3), typeIdentification);
          validateCodeEstablishment(ruc.substring(10, 13));
          algorithm11(ruc.substring(0,9), ruc.substring(9, 10), typeIdentification);
          break;
        case TypeIdentification.rucPublicSociety:
          validateThirdDigit(ruc.substring(2, 3), typeIdentification);
          validateCodeEstablishment(ruc.substring(9, 13));
          algorithm11(ruc.substring(0,8), ruc.substring(8, 9), typeIdentification);
          break;
        default:
          throw IdentificationException(
            ErrorCode.invalidType,
            'Invalid identification type'
          );
      }
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

  static IdentificationResult validateRuc ( String ruc ){
    final validRucNatural = validateRucByType(ruc, TypeIdentification.rucPersonNatural);
    final validRucPrivate = validateRucByType(ruc, TypeIdentification.rucSocietyPrivate);
    final validRucPublic = validateRucByType(ruc, TypeIdentification.rucPublicSociety);
    if ( !validRucNatural.isValid && !validRucPrivate.isValid && !validRucPublic.isValid ) {
      return IdentificationResult(
        isValid: false,
        errorMessage: validRucNatural.errorMessage ?? validRucPrivate.errorMessage ?? validRucPublic.errorMessage,
        typeCodeError: validRucPublic.typeCodeError ?? validRucPrivate.typeCodeError ?? validRucNatural.typeCodeError,
      );
    }
    return IdentificationResult(
      isValid: true,
      errorMessage: null,
      typeCodeError: null,
    );
  }
}