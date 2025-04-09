// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `hello in en`
  String get hello {
    return Intl.message(
      'hello in en',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Streamline Your Build with Cobuild`
  String get tutorial1Title {
    return Intl.message(
      'Streamline Your Build with Cobuild',
      name: 'tutorial1Title',
      desc: '',
      args: [],
    );
  }

  /// `Streamline`
  String get Streamline {
    return Intl.message(
      'Streamline',
      name: 'Streamline',
      desc: '',
      args: [],
    );
  }

  /// `Your Build`
  String get yourBuild {
    return Intl.message(
      'Your Build',
      name: 'yourBuild',
      desc: '',
      args: [],
    );
  }

  /// `with`
  String get withText {
    return Intl.message(
      'with',
      name: 'withText',
      desc: '',
      args: [],
    );
  }

  /// `Cobuild`
  String get cobuild {
    return Intl.message(
      'Cobuild',
      name: 'cobuild',
      desc: '',
      args: [],
    );
  }

  /// `Streamline Your Build with Cobuild`
  String get tutorial2Title {
    return Intl.message(
      'Streamline Your Build with Cobuild',
      name: 'tutorial2Title',
      desc: '',
      args: [],
    );
  }

  /// `Streamline Your Build with Cobuild`
  String get tutorial3Title {
    return Intl.message(
      'Streamline Your Build with Cobuild',
      name: 'tutorial3Title',
      desc: '',
      args: [],
    );
  }

  /// `Discover nearby construction projects with real-time updates. Connect with providers and access job schedules—all in one app.`
  String get tutorial1Description {
    return Intl.message(
      'Discover nearby construction projects with real-time updates. Connect with providers and access job schedules—all in one app.',
      name: 'tutorial1Description',
      desc: '',
      args: [],
    );
  }

  /// `Discover nearby construction projects with real-time updates. Connect with providers and access job schedules—all in one app.`
  String get tutorial2Description {
    return Intl.message(
      'Discover nearby construction projects with real-time updates. Connect with providers and access job schedules—all in one app.',
      name: 'tutorial2Description',
      desc: '',
      args: [],
    );
  }

  /// `Discover nearby construction projects with real-time updates. Connect with providers and access job schedules—all in one app.`
  String get tutorial3Description {
    return Intl.message(
      'Discover nearby construction projects with real-time updates. Connect with providers and access job schedules—all in one app.',
      name: 'tutorial3Description',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Verify Your Email`
  String get verifyYourEmail {
    return Intl.message(
      'Verify Your Email',
      name: 'verifyYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `A verification code has been sent to your email `
  String get aVerificationCodeHasBeenSent {
    return Intl.message(
      'A verification code has been sent to your email ',
      name: 'aVerificationCodeHasBeenSent',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t get code? `
  String get didntGetCode {
    return Intl.message(
      'Didn’t get code? ',
      name: 'didntGetCode',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP in `
  String get resendOtpIn {
    return Intl.message(
      'Resend OTP in ',
      name: 'resendOtpIn',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get resendOtp {
    return Intl.message(
      'Resend OTP',
      name: 'resendOtp',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get verifyOtp {
    return Intl.message(
      'Verify OTP',
      name: 'verifyOtp',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, we are facing technical issues. Please check back later.`
  String get somethingWentWrong {
    return Intl.message(
      'Sorry, we are facing technical issues. Please check back later.',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection`
  String get noInternet {
    return Intl.message(
      'Please check your internet connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Update Application`
  String get updateApplication {
    return Intl.message(
      'Update Application',
      name: 'updateApplication',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Update this app now for the latest features and fixes.`
  String get updateAppMessage {
    return Intl.message(
      'Update this app now for the latest features and fixes.',
      name: 'updateAppMessage',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Get Started now !`
  String get getStartedNow {
    return Intl.message(
      'Get Started now !',
      name: 'getStartedNow',
      desc: '',
      args: [],
    );
  }

  /// `Create an account or log in to explore about our app`
  String get createAccountOrLogin {
    return Intl.message(
      'Create an account or log in to explore about our app',
      name: 'createAccountOrLogin',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your registered email address, we will send an OTP to the associated email address`
  String get forgotPasswordDescription {
    return Intl.message(
      'Please enter your registered email address, we will send an OTP to the associated email address',
      name: 'forgotPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don’t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Or login with`
  String get orLoginWith {
    return Intl.message(
      'Or login with',
      name: 'orLoginWith',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `By creating an account, you're agreeing to our`
  String get byAggreeingTerms {
    return Intl.message(
      'By creating an account, you\'re agreeing to our',
      name: 'byAggreeingTerms',
      desc: '',
      args: [],
    );
  }

  /// `privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `user agreement`
  String get userAgreement {
    return Intl.message(
      'user agreement',
      name: 'userAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Complete Your Profile`
  String get completeYourProfile {
    return Intl.message(
      'Complete Your Profile',
      name: 'completeYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Please ensure that you've input the correct data as this information will be used to verify.`
  String get completeProfileDescription {
    return Intl.message(
      'Please ensure that you\'ve input the correct data as this information will be used to verify.',
      name: 'completeProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `*`
  String get requiredIcon {
    return Intl.message(
      '*',
      name: 'requiredIcon',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new password to reset the password`
  String get resetPassDescription {
    return Intl.message(
      'Enter a new password to reset the password',
      name: 'resetPassDescription',
      desc: '',
      args: [],
    );
  }

  /// `Successfully`
  String get successfully {
    return Intl.message(
      'Successfully',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been successfully created.`
  String get yourPasswordHasBeenSuccessfullyCreated {
    return Intl.message(
      'Your password has been successfully created.',
      name: 'yourPasswordHasBeenSuccessfullyCreated',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message(
      'Okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Accept User Agreement and Privacy Policy`
  String get acceptUserAggreementAndPrivacyPolcicy {
    return Intl.message(
      'Accept User Agreement and Privacy Policy',
      name: 'acceptUserAggreementAndPrivacyPolcicy',
      desc: '',
      args: [],
    );
  }

  /// `OTP Resended`
  String get otpResended {
    return Intl.message(
      'OTP Resended',
      name: 'otpResended',
      desc: '',
      args: [],
    );
  }

  /// `Estimate`
  String get estimate {
    return Intl.message(
      'Estimate',
      name: 'estimate',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Manage Notifications`
  String get manageNotifications {
    return Intl.message(
      'Manage Notifications',
      name: 'manageNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure? You want to logout from the application.`
  String get logoutConfirmation {
    return Intl.message(
      'Are you sure? You want to logout from the application.',
      name: 'logoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Toogle On/Off Notifications`
  String get toogleOnOffNotifications {
    return Intl.message(
      'Toogle On/Off Notifications',
      name: 'toogleOnOffNotifications',
      desc: '',
      args: [],
    );
  }

  /// `I understand that deleting my account will remove all my saved data, and i will not be able to recover it later.`
  String get deleteAccountDescription {
    return Intl.message(
      'I understand that deleting my account will remove all my saved data, and i will not be able to recover it later.',
      name: 'deleteAccountDescription',
      desc:
          'Your feedback means the world to us! If you\'re thinking about deleting your account, we\'d love to hear how we can improve.',
      args: [],
    );
  }

  /// `Are you sure, you want to delete your account?`
  String get deleteAccountConfirmation {
    return Intl.message(
      'Are you sure, you want to delete your account?',
      name: 'deleteAccountConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Reach out to our support team via`
  String get supportHeader {
    return Intl.message(
      'Reach out to our support team via',
      name: 'supportHeader',
      desc: '',
      args: [],
    );
  }

  /// `Get the help you need, when you need it, with our 24/7 support feature.`
  String get supportDescription {
    return Intl.message(
      'Get the help you need, when you need it, with our 24/7 support feature.',
      name: 'supportDescription',
      desc: '',
      args: [],
    );
  }

  /// `Email Us - `
  String get emailUs {
    return Intl.message(
      'Email Us - ',
      name: 'emailUs',
      desc: '',
      args: [],
    );
  }

  /// `No Content Found`
  String get noContentFound {
    return Intl.message(
      'No Content Found',
      name: 'noContentFound',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Your email address has been successfully verified.`
  String get emailVerifiedSuccess {
    return Intl.message(
      'Your email address has been successfully verified.',
      name: 'emailVerifiedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been created successfully.`
  String get accountCreatedSuccessfully {
    return Intl.message(
      'Your account has been created successfully.',
      name: 'accountCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `A strong password is your first line of defence. Change it often.`
  String get changePasswordDescription {
    return Intl.message(
      'A strong password is your first line of defence. Change it often.',
      name: 'changePasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been successfully changed.`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Your password has been successfully changed.',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your profile has been successfully updated.`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Your profile has been successfully updated.',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Account Deleted`
  String get accountDeleted {
    return Intl.message(
      'Account Deleted',
      name: 'accountDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been permanently deleted, and we're sad to say goodbye. But, keep in mind that the Cobuild is always here, waiting to welcome you back whenever you're ready to rejoin the app!`
  String get accountDeletedDescription {
    return Intl.message(
      'Your account has been permanently deleted, and we\'re sad to say goodbye. But, keep in mind that the Cobuild is always here, waiting to welcome you back whenever you\'re ready to rejoin the app!',
      name: 'accountDeletedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Please enable location services.`
  String get locationServiceRequiredDescription {
    return Intl.message(
      'Please enable location services.',
      name: 'locationServiceRequiredDescription',
      desc: '',
      args: [],
    );
  }

  /// `Enable`
  String get enable {
    return Intl.message(
      'Enable',
      name: 'enable',
      desc: '',
      args: [],
    );
  }

  /// `Please enable location services in the device settings manually.`
  String get enableLocationServiceManually {
    return Intl.message(
      'Please enable location services in the device settings manually.',
      name: 'enableLocationServiceManually',
      desc: '',
      args: [],
    );
  }

  /// `No Data Found`
  String get nodataFound {
    return Intl.message(
      'No Data Found',
      name: 'nodataFound',
      desc: '',
      args: [],
    );
  }

  /// `Congratulation!`
  String get congratulation {
    return Intl.message(
      'Congratulation!',
      name: 'congratulation',
      desc: '',
      args: [],
    );
  }

  /// `No notifications yet !`
  String get noNotificationsYet {
    return Intl.message(
      'No notifications yet !',
      name: 'noNotificationsYet',
      desc: '',
      args: [],
    );
  }

  /// `You have no notifications right now.\nCome back later`
  String get noNotificationsDesc {
    return Intl.message(
      'You have no notifications right now.\nCome back later',
      name: 'noNotificationsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Search Location`
  String get searchLocation {
    return Intl.message(
      'Search Location',
      name: 'searchLocation',
      desc: '',
      args: [],
    );
  }

  /// `Search Jobs`
  String get searchJobs {
    return Intl.message(
      'Search Jobs',
      name: 'searchJobs',
      desc: '',
      args: [],
    );
  }

  /// `Hi`
  String get hi {
    return Intl.message(
      'Hi',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `No Location Found`
  String get noLocationFound {
    return Intl.message(
      'No Location Found',
      name: 'noLocationFound',
      desc: '',
      args: [],
    );
  }

  /// `QR Code Job Search and Instant Job Details Access`
  String get qrCodeJobSearchHeader {
    return Intl.message(
      'QR Code Job Search and Instant Job Details Access',
      name: 'qrCodeJobSearchHeader',
      desc: '',
      args: [],
    );
  }

  /// `Track job & Connect with just a scan.`
  String get qrCodeJobSearchTitle {
    return Intl.message(
      'Track job & Connect with just a scan.',
      name: 'qrCodeJobSearchTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan Now`
  String get scanNow {
    return Intl.message(
      'Scan Now',
      name: 'scanNow',
      desc: '',
      args: [],
    );
  }

  /// `Estimates & Discover`
  String get estimatesAndDiscover {
    return Intl.message(
      'Estimates & Discover',
      name: 'estimatesAndDiscover',
      desc: '',
      args: [],
    );
  }

  /// `Nearby Jobs`
  String get nearbyJobs {
    return Intl.message(
      'Nearby Jobs',
      name: 'nearbyJobs',
      desc: '',
      args: [],
    );
  }

  /// `Estimates`
  String get estimates {
    return Intl.message(
      'Estimates',
      name: 'estimates',
      desc: '',
      args: [],
    );
  }

  /// `Opportunity Map`
  String get opportunityMap {
    return Intl.message(
      'Opportunity Map',
      name: 'opportunityMap',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message(
      'View all',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Search by Name/Job Title`
  String get searchByNameTitle {
    return Intl.message(
      'Search by Name/Job Title',
      name: 'searchByNameTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter Location Manually`
  String get enterLocationManually {
    return Intl.message(
      'Enter Location Manually',
      name: 'enterLocationManually',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please select location again.`
  String get reselectLocation {
    return Intl.message(
      'Something went wrong, please select location again.',
      name: 'reselectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Job Detail`
  String get jobDetail {
    return Intl.message(
      'Job Detail',
      name: 'jobDetail',
      desc: '',
      args: [],
    );
  }

  /// `Job Procedure`
  String get jobProcedure {
    return Intl.message(
      'Job Procedure',
      name: 'jobProcedure',
      desc: '',
      args: [],
    );
  }

  /// `Contact Information of On-site Manager`
  String get contactInformationOfManager {
    return Intl.message(
      'Contact Information of On-site Manager',
      name: 'contactInformationOfManager',
      desc: '',
      args: [],
    );
  }

  /// `Service Category`
  String get serviceCategory {
    return Intl.message(
      'Service Category',
      name: 'serviceCategory',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get schedule {
    return Intl.message(
      'Schedule',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `About Company`
  String get aboutCompany {
    return Intl.message(
      'About Company',
      name: 'aboutCompany',
      desc: '',
      args: [],
    );
  }

  /// `Dynamic Map View`
  String get dynamicMapView {
    return Intl.message(
      'Dynamic Map View',
      name: 'dynamicMapView',
      desc: '',
      args: [],
    );
  }

  /// `Click to view`
  String get clickToView {
    return Intl.message(
      'Click to view',
      name: 'clickToView',
      desc: '',
      args: [],
    );
  }

  /// `Chat with us`
  String get chatWithUs {
    return Intl.message(
      'Chat with us',
      name: 'chatWithUs',
      desc: '',
      args: [],
    );
  }

  /// `Requested On:`
  String get requestedOn {
    return Intl.message(
      'Requested On:',
      name: 'requestedOn',
      desc: '',
      args: [],
    );
  }

  /// `Request Form`
  String get requestForm {
    return Intl.message(
      'Request Form',
      name: 'requestForm',
      desc: '',
      args: [],
    );
  }

  /// `Request Detail`
  String get requestDetail {
    return Intl.message(
      'Request Detail',
      name: 'requestDetail',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get categoryName {
    return Intl.message(
      'Category Name',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Request On`
  String get requestOn {
    return Intl.message(
      'Request On',
      name: 'requestOn',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Days`
  String get estimatedDays {
    return Intl.message(
      'Estimated Days',
      name: 'estimatedDays',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Amount`
  String get estimatedAmount {
    return Intl.message(
      'Estimated Amount',
      name: 'estimatedAmount',
      desc: '',
      args: [],
    );
  }

  /// `Quotation`
  String get quotation {
    return Intl.message(
      'Quotation',
      name: 'quotation',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Reported Damage`
  String get reportedDamage {
    return Intl.message(
      'Reported Damage',
      name: 'reportedDamage',
      desc: '',
      args: [],
    );
  }

  /// `Report Damage`
  String get reportDamage {
    return Intl.message(
      'Report Damage',
      name: 'reportDamage',
      desc: '',
      args: [],
    );
  }

  /// `Reported on`
  String get reportedOn {
    return Intl.message(
      'Reported on',
      name: 'reportedOn',
      desc: '',
      args: [],
    );
  }

  /// `Type of Damage`
  String get typeOfDamage {
    return Intl.message(
      'Type of Damage',
      name: 'typeOfDamage',
      desc: '',
      args: [],
    );
  }

  /// `Select Location`
  String get selectLocation {
    return Intl.message(
      'Select Location',
      name: 'selectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Job Location`
  String get jobLocation {
    return Intl.message(
      'Job Location',
      name: 'jobLocation',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Paused`
  String get paused {
    return Intl.message(
      'Paused',
      name: 'paused',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message(
      'Upcoming',
      name: 'upcoming',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `1 year to now`
  String get ascendingOrder {
    return Intl.message(
      '1 year to now',
      name: 'ascendingOrder',
      desc: '',
      args: [],
    );
  }

  /// `Now to 1 year`
  String get descendingOrder {
    return Intl.message(
      'Now to 1 year',
      name: 'descendingOrder',
      desc: '',
      args: [],
    );
  }

  /// `Select current location`
  String get selectCurrentLocation {
    return Intl.message(
      'Select current location',
      name: 'selectCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Scheduled`
  String get scheduled {
    return Intl.message(
      'Scheduled',
      name: 'scheduled',
      desc: '',
      args: [],
    );
  }

  /// `In-Progress`
  String get inprogress {
    return Intl.message(
      'In-Progress',
      name: 'inprogress',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Deleted`
  String get deleted {
    return Intl.message(
      'Deleted',
      name: 'deleted',
      desc: '',
      args: [],
    );
  }

  /// `Sort By Date`
  String get basedOnCreatedDate {
    return Intl.message(
      'Sort By Date',
      name: 'basedOnCreatedDate',
      desc: '',
      args: [],
    );
  }

  /// `Posted`
  String get posted {
    return Intl.message(
      'Posted',
      name: 'posted',
      desc: '',
      args: [],
    );
  }

  /// `No Jobs Found`
  String get noJobPostedYet {
    return Intl.message(
      'No Jobs Found',
      name: 'noJobPostedYet',
      desc: '',
      args: [],
    );
  }

  /// `Door Tag`
  String get doorTag {
    return Intl.message(
      'Door Tag',
      name: 'doorTag',
      desc: '',
      args: [],
    );
  }

  /// `Job found`
  String get jobFound {
    return Intl.message(
      'Job found',
      name: 'jobFound',
      desc: '',
      args: [],
    );
  }

  /// `Jobs found`
  String get jobsFound {
    return Intl.message(
      'Jobs found',
      name: 'jobsFound',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR`
  String get scanQR {
    return Intl.message(
      'Scan QR',
      name: 'scanQR',
      desc: '',
      args: [],
    );
  }

  /// `Invalid QR, Please try again`
  String get invalidQR {
    return Intl.message(
      'Invalid QR, Please try again',
      name: 'invalidQR',
      desc: '',
      args: [],
    );
  }

  /// `Active Requests`
  String get activeRequest {
    return Intl.message(
      'Active Requests',
      name: 'activeRequest',
      desc: '',
      args: [],
    );
  }

  /// `Accepted Requests`
  String get acceptedRequests {
    return Intl.message(
      'Accepted Requests',
      name: 'acceptedRequests',
      desc: '',
      args: [],
    );
  }

  /// `No estimate request`
  String get noEstimateRequest {
    return Intl.message(
      'No estimate request',
      name: 'noEstimateRequest',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get approved {
    return Intl.message(
      'Approved',
      name: 'approved',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected {
    return Intl.message(
      'Rejected',
      name: 'rejected',
      desc: '',
      args: [],
    );
  }

  /// `Something Went Wrong`
  String get somethingWentWrongWithoutRetry {
    return Intl.message(
      'Something Went Wrong',
      name: 'somethingWentWrongWithoutRetry',
      desc: '',
      args: [],
    );
  }

  /// `No service category found`
  String get noServiceCategoryFound {
    return Intl.message(
      'No service category found',
      name: 'noServiceCategoryFound',
      desc: '',
      args: [],
    );
  }

  /// `Select Service`
  String get selectService {
    return Intl.message(
      'Select Service',
      name: 'selectService',
      desc: '',
      args: [],
    );
  }

  /// `Browse and choose the files you want to Add Size up to 5mb`
  String get selectMediaDescription {
    return Intl.message(
      'Browse and choose the files you want to Add Size up to 5mb',
      name: 'selectMediaDescription',
      desc: '',
      args: [],
    );
  }

  /// `Enter Custom Service`
  String get enterCustomService {
    return Intl.message(
      'Enter Custom Service',
      name: 'enterCustomService',
      desc: '',
      args: [],
    );
  }

  /// `Select Consulting Services`
  String get selectConsultingServices {
    return Intl.message(
      'Select Consulting Services',
      name: 'selectConsultingServices',
      desc: '',
      args: [],
    );
  }

  /// `Select Category`
  String get selectCategory {
    return Intl.message(
      'Select Category',
      name: 'selectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category Service`
  String get categoryService {
    return Intl.message(
      'Category Service',
      name: 'categoryService',
      desc: '',
      args: [],
    );
  }

  /// `Custom Service`
  String get customService {
    return Intl.message(
      'Custom Service',
      name: 'customService',
      desc: '',
      args: [],
    );
  }

  /// `Cable Consulting Service`
  String get cableConsultingService {
    return Intl.message(
      'Cable Consulting Service',
      name: 'cableConsultingService',
      desc: 'Valeus used in cable consulting service',
      args: [],
    );
  }

  /// `Estimate request has been submitted successfully`
  String get estimatedRequestCreated {
    return Intl.message(
      'Estimate request has been submitted successfully',
      name: 'estimatedRequestCreated',
      desc: '',
      args: [],
    );
  }

  /// `Estimate request has been updated successfully`
  String get estimatedRequestUpdated {
    return Intl.message(
      'Estimate request has been updated successfully',
      name: 'estimatedRequestUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Selected File`
  String get selectedFile {
    return Intl.message(
      'Selected File',
      name: 'selectedFile',
      desc: '',
      args: [],
    );
  }

  /// `File size must not exceed 5 MB.`
  String get mediaSizeError {
    return Intl.message(
      'File size must not exceed 5 MB.',
      name: 'mediaSizeError',
      desc: '',
      args: [],
    );
  }

  /// `Error selecting media`
  String get errorSelectingMedia {
    return Intl.message(
      'Error selecting media',
      name: 'errorSelectingMedia',
      desc: '',
      args: [],
    );
  }

  /// `Error capturing image`
  String get errorCapturingImage {
    return Intl.message(
      'Error capturing image',
      name: 'errorCapturingImage',
      desc: '',
      args: [],
    );
  }

  /// `Select Option`
  String get selectOption {
    return Intl.message(
      'Select Option',
      name: 'selectOption',
      desc: '',
      args: [],
    );
  }

  /// `Capture from Camera`
  String get captureFromCamera {
    return Intl.message(
      'Capture from Camera',
      name: 'captureFromCamera',
      desc: '',
      args: [],
    );
  }

  /// `Upload from Files`
  String get uploadFromFiles {
    return Intl.message(
      'Upload from Files',
      name: 'uploadFromFiles',
      desc: '',
      args: [],
    );
  }

  /// `Select Issue`
  String get selectIssue {
    return Intl.message(
      'Select Issue',
      name: 'selectIssue',
      desc: '',
      args: [],
    );
  }

  /// `Billing & Account Issues`
  String get billingAndAccountIssues {
    return Intl.message(
      'Billing & Account Issues',
      name: 'billingAndAccountIssues',
      desc: '',
      args: [],
    );
  }

  /// `Internet Connectivity Problems`
  String get internetConnectivityProblems {
    return Intl.message(
      'Internet Connectivity Problems',
      name: 'internetConnectivityProblems',
      desc: '',
      args: [],
    );
  }

  /// `Utilities & Services Issues`
  String get utilitiesAndServicesIssues {
    return Intl.message(
      'Utilities & Services Issues',
      name: 'utilitiesAndServicesIssues',
      desc: '',
      args: [],
    );
  }

  /// `Damage & Repairs`
  String get damageAndRepairs {
    return Intl.message(
      'Damage & Repairs',
      name: 'damageAndRepairs',
      desc: '',
      args: [],
    );
  }

  /// `Home Projects & Installations`
  String get homeProjectsAndInstallations {
    return Intl.message(
      'Home Projects & Installations',
      name: 'homeProjectsAndInstallations',
      desc: '',
      args: [],
    );
  }

  /// `General Consulting & Support`
  String get generalConsultingAndSupport {
    return Intl.message(
      'General Consulting & Support',
      name: 'generalConsultingAndSupport',
      desc: '',
      args: [],
    );
  }

  /// `Internet Bill Issues`
  String get internetBillIssues {
    return Intl.message(
      'Internet Bill Issues',
      name: 'internetBillIssues',
      desc: '',
      args: [],
    );
  }

  /// `Utility Bill Issues`
  String get utilityBillIssues {
    return Intl.message(
      'Utility Bill Issues',
      name: 'utilityBillIssues',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Charges`
  String get unexpectedCharges {
    return Intl.message(
      'Unexpected Charges',
      name: 'unexpectedCharges',
      desc: '',
      args: [],
    );
  }

  /// `Payment Plans or Assistance`
  String get paymentPlansOrAssistance {
    return Intl.message(
      'Payment Plans or Assistance',
      name: 'paymentPlansOrAssistance',
      desc: '',
      args: [],
    );
  }

  /// `Company Address`
  String get compnayAddress {
    return Intl.message(
      'Company Address',
      name: 'compnayAddress',
      desc: '',
      args: [],
    );
  }

  /// `Provide all required details`
  String get provideRequiredDetails {
    return Intl.message(
      'Provide all required details',
      name: 'provideRequiredDetails',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure, you want to delete the request`
  String get deleteEstimateRequest {
    return Intl.message(
      'Are you sure, you want to delete the request',
      name: 'deleteEstimateRequest',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Error loading media`
  String get errorLoadingMedia {
    return Intl.message(
      'Error loading media',
      name: 'errorLoadingMedia',
      desc: '',
      args: [],
    );
  }

  /// `Media`
  String get media {
    return Intl.message(
      'Media',
      name: 'media',
      desc: '',
      args: [],
    );
  }

  /// `Add Damage Description`
  String get addDamageDescription {
    return Intl.message(
      'Add Damage Description',
      name: 'addDamageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add Location`
  String get addLocation {
    return Intl.message(
      'Add Location',
      name: 'addLocation',
      desc: '',
      args: [],
    );
  }

  /// `Damage report has been submitted successfully`
  String get damageReportedSuccessfully {
    return Intl.message(
      'Damage report has been submitted successfully',
      name: 'damageReportedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Report Detail`
  String get reportDetail {
    return Intl.message(
      'Report Detail',
      name: 'reportDetail',
      desc: '',
      args: [],
    );
  }

  /// `No reported damages`
  String get noReportedDamages {
    return Intl.message(
      'No reported damages',
      name: 'noReportedDamages',
      desc: '',
      args: [],
    );
  }

  /// `No data found`
  String get noDataFound {
    return Intl.message(
      'No data found',
      name: 'noDataFound',
      desc: '',
      args: [],
    );
  }

  /// `Upload from Gallery`
  String get uploadFromGallery {
    return Intl.message(
      'Upload from Gallery',
      name: 'uploadFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Add More`
  String get addMore {
    return Intl.message(
      'Add More',
      name: 'addMore',
      desc: '',
      args: [],
    );
  }

  /// `The maximum image upload limit is 5`
  String get maxImageLimit {
    return Intl.message(
      'The maximum image upload limit is 5',
      name: 'maxImageLimit',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Clear all`
  String get clearAll {
    return Intl.message(
      'Clear all',
      name: 'clearAll',
      desc: '',
      args: [],
    );
  }

  /// `Delete Notification`
  String get deleteNotification {
    return Intl.message(
      'Delete Notification',
      name: 'deleteNotification',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to Delete this notification`
  String get deleteNotificationDetails {
    return Intl.message(
      'Are you sure you want to Delete this notification',
      name: 'deleteNotificationDetails',
      desc: '',
      args: [],
    );
  }

  /// `Clear All Notification`
  String get clearAllNotifications {
    return Intl.message(
      'Clear All Notification',
      name: 'clearAllNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to clear all the notifications`
  String get clearAllNotificationsDescription {
    return Intl.message(
      'Are you sure you want to clear all the notifications',
      name: 'clearAllNotificationsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Your Quote`
  String get yourQuote {
    return Intl.message(
      'Your Quote',
      name: 'yourQuote',
      desc: '',
      args: [],
    );
  }

  /// `No Message Yet`
  String get noMessages {
    return Intl.message(
      'No Message Yet',
      name: 'noMessages',
      desc: '',
      args: [],
    );
  }

  /// `You're offline`
  String get offlineMessage {
    return Intl.message(
      'You\'re offline',
      name: 'offlineMessage',
      desc: '',
      args: [],
    );
  }

  /// `sending...`
  String get sendingMessage {
    return Intl.message(
      'sending...',
      name: 'sendingMessage',
      desc: '',
      args: [],
    );
  }

  /// `failed`
  String get failed {
    return Intl.message(
      'failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Quotation Reply :- `
  String get quotationReply {
    return Intl.message(
      'Quotation Reply :- ',
      name: 'quotationReply',
      desc: '',
      args: [],
    );
  }

  /// `No chat found`
  String get noChatFound {
    return Intl.message(
      'No chat found',
      name: 'noChatFound',
      desc: '',
      args: [],
    );
  }

  /// `Photo Access Required`
  String get permissionNeeded {
    return Intl.message(
      'Photo Access Required',
      name: 'permissionNeeded',
      desc: '',
      args: [],
    );
  }

  /// `To upload or take photos, the app needs permission to access your camera and photo library. You can enable access anytime in your device Settings.`
  String get cameraPermission {
    return Intl.message(
      'To upload or take photos, the app needs permission to access your camera and photo library. You can enable access anytime in your device Settings.',
      name: 'cameraPermission',
      desc: '',
      args: [],
    );
  }

  /// `Open Settings`
  String get openSettings {
    return Intl.message(
      'Open Settings',
      name: 'openSettings',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
