import 'package:ec_validator/entities/index.dart';

class IdentificationException implements Exception {
  final String message;
  final ErrorCode code;

  IdentificationException(this.code, this.message);

  @override
  String toString() => 'Error $code: $message';
}