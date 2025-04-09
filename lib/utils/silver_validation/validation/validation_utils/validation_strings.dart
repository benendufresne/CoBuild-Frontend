part of '../validation.dart';

class ValidationStrings {
  const ValidationStrings({this.field = "Field"});

  final String field;

  String get improperEmail => 'Enter a valid Email Address';
  String get improperUpi => 'Enter valid Upi ID';
  String get invalidLengthPassword => 'Enter at least 8 characters';
  String get improperPassword => 'Enter the password in the correct format';
  String get improperPhone => 'Invalid Mobile No.';
  String get invalidLengthPhone => 'Phone Number must be of 10 digits';
  String get incorrectRepeatPassword =>
      "Password doesn't match, please try again";
  String get improperName => 'Enter valid name';
  String get improperAddress =>
      'Address should be a minimum of 1 - 50 characters';
  String get improperCustomSericeName =>
      'Custom serive name should be a minimum of 1 - 50 characters';
  String get emptyField => '$field cannot be Empty';
  String get nullField => '$field is required';
  String get improperDecimal => 'Enter a Proper Number';
  String get improperSpaceName => 'Name Cannot contain Empty Spaces';
  String get improperDate => 'Please Enter a Proper in the format dd/mm/yyyy';
  String get improperPercentage => 'Enter a proper Number';
  String get improperFirstPhone => 'Number must not start with 0';
  String get improperCountryCodeFirst => "Country Code must start with '+'";
  String get improperCountryCode => 'Enter a proper country code';
  String get improperSingleNumber => 'Enter a Proper Number';
  String get invalidLengthSingleNumber => 'Value must be of only 1 digit';
  String get invalidLengthString => '$field cannot be less than 3 Letters';
  String get invalidSearchLengthString =>
      'Search field cannot be less than 2 Letters';
  String get emptyFirstName => 'Enter First Name';
  String get emptyUserName => 'Enter User Name';
  String get emptyHeight => 'Enter Your Height';
  String get emptyCVV => 'Enter CVV';
  String get emptyAccountNumber => 'Enter Your Account Number';
  String get emptyParticipants => 'Enter Participants Number';
  String get groupCode => 'Enter Participants Number';
  String get emptyParticipantsFees => 'Enter Participants Fees';
  String get enterBettingAmountFees => 'Enter Betting Amount Fees';
  String get enterMinDistanceFees => 'Enter Minimum Distance';
  String get emptyWeight => 'Enter Your Weight';
  String get emptyName => 'Enter User Name';
  String get emptyAdharNumber => 'Enter Aadhaar Number';
  String get emptyAddress => 'Enter Your Address';
  String get emptyDateofBirth => 'Enter Your Date Of Birth';
  String get emptyLocation => 'Enter Location';
  String get emptyCaptcha => 'Enter Captcha';
  String get emptyDescription => 'Enter Description';
  String get emptyEmail => 'Enter Email';
  String get emptyUpi => 'Enter Upi';
  String get emptyPinCode => 'Enter Pin Code';
  String get invalidFirstName => 'Requires Min 2 and Max 50 characters';
  String get emptyLastName => 'Enter Last Name';
  String get invalidLastName => 'Requires Min 2 and Max 50 characters';
  String get emptyPhone => 'Enter Phone Number';
  String get emptyPassword => 'Enter the password in the correct format';
}
