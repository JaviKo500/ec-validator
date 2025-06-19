import 'package:ec_validator/entities/index.dart';
import 'package:ec_validator/exceptions/index.dart';

void validateCodeProvince ( String codeProvince ) {
  const int minProvinceCode = 0;
  const int maxProvinceCode = 24;
  final code = int.tryParse(codeProvince);
  
  if ( code == 30 ) return;

  if ( code == null ||code < minProvinceCode || code > maxProvinceCode) {
    throw IdentificationException(
      ErrorCode.invalidCodeProvince,
      'Invalid province code: the first two digits must be a number between 00 - 24 and 30 foreign.',
    );
  }
}