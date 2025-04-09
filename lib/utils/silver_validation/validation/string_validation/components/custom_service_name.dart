part of '../../validation.dart';

class CustomSerivceNameValidation extends StringValidation {
  const CustomSerivceNameValidation({super.strings});

  @override
  ValidationResult validate({required String input}) {
    if (input.isEmpty) {
      return isEmptyResult;
    }

    return const ValidationResult.proper();
  }

  ValidationResult get isEmptyResult =>
      ValidationResult(message: strings.emptyField);

  ValidationResult get isImproperResult =>
      ValidationResult(message: strings.improperAddress);
}
