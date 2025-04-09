part of '../validation.dart';

class StringValidations {
  const StringValidations._internal();

  StringValidation email({RegExp? emailChecker, ValidationStrings? strings}) =>
      EmailValidation(emailChecker: emailChecker, strings: strings);
  PasswordValidation password(
          {RegExp? passwordChecker, ValidationStrings? strings}) =>
      PasswordValidation(passwordChecker: passwordChecker, strings: strings);
  RepeatPasswordValidatedController confirmPassword(
          {required ValidatedController<PasswordValidation> passwordController,
          ValidationStrings? strings}) =>
      RepeatPasswordValidatedController(
          mainPasswordController: passwordController);
  StringValidation custom(StringValidationLogic logic,
          {ValidationStrings? strings}) =>
      CustomStringValidation(logic: logic, strings: strings);

  StringValidation countryCode({ValidationStrings? strings}) =>
      CountryCodeValidation(strings: strings);
  StringValidation name({ValidationStrings? strings}) =>
      NameValidation(strings: strings);
  StringValidation addrress({ValidationStrings? strings}) =>
      AddressValidation(strings: strings);
  StringValidation text({ValidationStrings? strings}) =>
      TextValidation(strings: strings);
  StringValidation searchJob({ValidationStrings? strings}) =>
      SearchJobValidation(strings: strings);
  StringValidation numeric({ValidationStrings? strings}) =>
      SingleNumericValidation(strings: strings);
  StringValidation phone({ValidationStrings? strings}) =>
      PhoneValidation(strings: strings);
  StringValidation firstName({ValidationStrings? strings}) =>
      FirstNameValidator(strings: strings);
  StringValidation lastName({ValidationStrings? strings}) =>
      LastNameValidator(strings: strings);
  StringValidation usPhone({ValidationStrings? strings}) =>
      USPhoneValidation(strings: strings);
  // Create Estimate Request
  StringValidation customServiceName({ValidationStrings? strings}) =>
      CustomSerivceNameValidation(strings: strings);
  StringValidation alwaysProper() => const AlwaysProperValidation();
  StringValidation none() => const NoneValidation();
}
