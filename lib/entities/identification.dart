enum TypeIdentification {
  dni,
  ruc,
  rucPersonNatural,
  rucSocietyPrivate,
  rucPublicSociety,
}

class IdentificationResult {
  final bool isValid;
  final String? errorMessage;
  final ErrorCode? typeCodeError;

  IdentificationResult({
    required this.isValid,
    this.errorMessage,
    this.typeCodeError,
  });
}

enum ErrorCode {
  invalidLength,
  invalidType,
  invalidCheckDigit,
}