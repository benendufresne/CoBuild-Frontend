part of '../../validation.dart';

class SearchJobValidation extends StringValidation {
  const SearchJobValidation({super.strings});

  @override
  ValidationResult validate({required String input}) {
    if (input.trim().isEmpty) {
      return const ValidationResult.proper();
    }

    if (input.length < 2) {
      return ValidationResult(message: strings.invalidSearchLengthString);
    }

    return const ValidationResult.proper();
  }
}
