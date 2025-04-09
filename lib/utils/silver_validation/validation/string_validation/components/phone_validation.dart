part of '../../validation.dart';

class PhoneValidation extends StringValidation {
  const PhoneValidation({super.strings});

  @override
  ValidationResult validate({required String input}) {
    if (input.isEmpty) {
      return ValidationResult(message: strings.emptyPhone);
    }
    if (ValidationRegex.inverseNumberOnlyFilter.hasMatch(input)) {
      return ValidationResult(message: strings.invalidLengthPhone);
    } else if (input[0] == '0') {
      return ValidationResult(message: strings.invalidLengthPhone);
    }

    if (input.length != 10) {
      return ValidationResult(message: strings.invalidLengthPhone);
    }
    return const ValidationResult.proper();
  }
}
