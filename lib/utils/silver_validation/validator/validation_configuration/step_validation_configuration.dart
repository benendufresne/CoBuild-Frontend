part of '../validator.dart';

class StepValidationConfiguration<T extends ValidatedController>
    extends ValidationConfiguration<T> {
  @override
  ValidationError? transform(ValidationResult error, ValidationMode mode) {
    if (error.isProper && mode.isEnabled) {
      mode = const PassiveValidationMode();
    }
    validator.updateValidationMode(mode);
    return super.transform(error, mode);
  }
}
