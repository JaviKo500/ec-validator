import 'package:ec_validations/ec_validations.dart';

class EcMessagesPt implements EcValidationsMessages {

  @override
  String get localeCode => 'pt';

  @override
  String message(EcMessageKey key, [Map<String, Object?> args = const {}]) {

    switch (key) {
      // Identification
      case EcMessageKey.identificationEmpty:
        return 'A identificação não pode estar vazia';

      case EcMessageKey.identificationInvalidType:
        return 'Tipo de identificação inválido';

      case EcMessageKey.identificationInvalid:
        return 'Identificação inválida';

      case EcMessageKey.identificationNotNumber:
        return 'Identificação inválida: deve ser um número.';

      case EcMessageKey.identificationLengthOrFormat:
        final digits = args['digits'] ?? 10;
        return 'Identificação inválida: deve ter exatamente $digits '
            'dígitos e conter apenas números.';

      case EcMessageKey.verificationDigitNotNumber:
        return 'Dígito verificador inválido: deve ser um número.';

      case EcMessageKey.verificationDigitInvalid:
        return 'Dígito verificador inválido.';

      case EcMessageKey.codeEstablishmentNotNumber:
        return 'Código do estabelecimento inválido: deve ser um número.';

      case EcMessageKey.codeEstablishmentZero:
        return 'Código do estabelecimento inválido: deve ser um número maior '
            'que 0.';

      case EcMessageKey.codeProvinceInvalid:
        return 'Código da província inválido: os dois primeiros dígitos devem '
            'ser um número entre 00 e 24.';

      case EcMessageKey.thirdDigitNotNumber:
        return 'Terceiro dígito inválido: deve ser um número.';

      case EcMessageKey.thirdDigitOutOfRange:
        return 'Terceiro dígito inválido: deve ser um número entre 0 e 9.';

      case EcMessageKey.thirdDigitMustBeNine:
        return 'Terceiro dígito inválido: deve ser um número igual a 9.';

      case EcMessageKey.thirdDigitMustBeSix:
        return 'Terceiro dígito inválido: deve ser um número igual a 6.';

      // RUC
      case EcMessageKey.rucInvalid:
        return 'RUC inválido';

      // Phone
      case EcMessageKey.phoneEmpty:
        return 'O número de telefone não pode estar vazio.';

      case EcMessageKey.phoneInvalid:
        return 'Número de telefone inválido';

      case EcMessageKey.phoneLocalLength:
        return 'O número de telefone deve ter exatamente 10 caracteres '
            'para um celular ou 9 para um telefone fixo.';

      case EcMessageKey.phoneLocalFormat:
        return 'O número de telefone deve começar com 09 para um celular ou '
            'com 02 a 07 para um telefone fixo.';

      case EcMessageKey.phoneCountryCode:
        final countryCode = args['countryCode'] ?? '+593';
        return 'O número de telefone deve começar com o código do país do '
            'Equador $countryCode.';

      case EcMessageKey.phoneInternationalLength:
        final countryCode = args['countryCode'] ?? '+593';
        return 'O número de telefone deve ter exatamente 9 dígitos '
            'após $countryCode para um celular ou 8 para um telefone '
            'fixo.';

      case EcMessageKey.phoneInternationalFormat:
        final countryCode = args['countryCode'] ?? '+593';
        return 'O número de telefone deve continuar com 9 para um celular ou '
            'com 2 a 7 para um telefone fixo após $countryCode.';
    }
  }
}