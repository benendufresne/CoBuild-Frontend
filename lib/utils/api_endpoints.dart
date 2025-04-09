abstract class ApiEndpoints {
  static const String _userApis = 'user/api/v1/user';
  static const String sendSignupOtp = "$_userApis/signup";
  static const String sendOtp = "$_userApis/send-otp";
  static const String verifySignupEmailOtp = "$_userApis/verify-otp";
  static const String userProfile = "$_userApis/profile";
  static const String getStaticContent = "$_userApis/getStaticContent";
  static const String checkAppVersion = "$_userApis/checkAppVersion";
  static const String logout = "$_userApis/logout";
  static const String deleteAccount = "$_userApis/delete";
  static const String changePassword = "$_userApis/change-password";

  /// Onboarding
  static const String login = "$_userApis/login";

  /// Forgot Password
  static const String forgotPassword = "$_userApis/forgotPassword";
  static const String resetPassword = "$_userApis/reset-password";

  /// For Social Signup
  static const String socialLogin = "$_userApis/social-signup";

  // Upload Media :- Presigned
  static const String getMediaUrl = "$_userApis/preSignedUrl";

  // Jobs
  static const String jobList = "$_userApis/home";
  static const String jobDetails = "$_userApis/job";
  static const String serviceCategoryList = "$_userApis/service-category-list";

  // Estimates
  static const String estimateRequest = "$_userApis/request";
  static const String estimateList = "$_userApis/request-list";

  // Report Damange
  static const String reportDamange = "$_userApis/report-damage";
  static const String reportDamangeList = "$_userApis/report-list";

  // Notifications
  static const String notificationsList = "$_userApis/notification-list";
  static const String notificationsClear = "$_userApis/notification-clear";
  static const String readNotifications = "$_userApis/notification-read";

  // Chat
  static const String chatList = "_inbox_chat";
  // Chat API :-
  static const String getJobChatId = "$_userApis/job-chat";

  /// Static content :-
  static const String aboutUs = "/about-us";
  static const String privacyPolicy = "/privacy-policy";
  static const String termsAndConditions = "/terms-condition";

  /// Content API's
  static const String _contentApis = 'admin/api/v1/contents';
  static const String faq = "$_contentApis/faq-list";

  /// Google Place API
  static const String googlePlacesApiNew =
      "https://places.googleapis.com/v1/places";
}
