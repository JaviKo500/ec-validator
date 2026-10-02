import 'package:ec_validations/ec_validations.dart';

/// Common view of the results returned by the `ec_validations` validators.
class DemoResult {
  final bool isValid;
  final String? typeCodeError;
  final String? errorMessage;
  final String? messageInEn;

  /// Only phone results carry a normalized number.
  final String? normalizedNumber;

  const DemoResult({
    required this.isValid,
    this.typeCodeError,
    this.errorMessage,
    this.messageInEn,
    this.normalizedNumber,
  });

  factory DemoResult.identification(IdentificationResult result) => DemoResult(
    isValid: result.isValid,
    typeCodeError: result.typeCodeError?.toString(),
    errorMessage: result.errorMessage,
    messageInEn: result.messageIn(EcMessagesEn()),
  );

  factory DemoResult.phone(PhoneResult result) => DemoResult(
    isValid: result.isValid,
    typeCodeError: result.typeCodeError?.toString(),
    errorMessage: result.errorMessage,
    messageInEn: result.messageIn(EcMessagesEn()),
    normalizedNumber: result.normalizedNumber,
  );
}
