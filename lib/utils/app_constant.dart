class AppConstant {
  static const int phoneNumberMaxLimit = 10;
  static const int nameMaxLimit = 25;
  static const int emailMaxLimit = 50;
  static const int passwordMaxLength = 25;
  static const int addressMaxLength = 50;
  static const int searchMaxLength = 50;
  // Estimate
  static const int nameMaxLimitInEstimate = 40;
  static const int maxCustomEstimateName = 50;

  // Create Estimate Request
  static const int descriptionMaxLength = 500;

  // Report
  static const int reportDamageDescriptionMaxLength = 500;
  static const int typeOfDamageMaxLength = 50;

  // Chat
  static const int chatSearchMaxLength = 50;
  static const int chatMessageMaxLength = 500;

  static const String androidAppLink = "https://play.google.com/store/apps/";
  static const String iosAppLink = "https://apps.apple.com/app/";
  static const String supportEmail = "Support@cobuild.com";
  static const String passwordFormat =
      "Password must contain between 8-25 characters,  1 uppercase, 1 lowercase, 1 number and 1 special character.";
}
