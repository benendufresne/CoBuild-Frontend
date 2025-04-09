import 'package:cobuild/utils/services/https_services/http_helper.dart';

abstract class AppBaseUrl {
  static String devBaseUrl = 'https://cobuildapidev.appskeeper.in/';
  static String qaBaseUrl = 'https://cobuildapiqa.appskeeper.in/';
  static String stageBaseUrl = 'https://preprod-api.cobuildapp.net/';
  static String productionBaseUrl = 'https://prod-api.cobuildapp.net/';
}

abstract class SocketBaseUrl {
  static String devBaseUrl = 'https://cobuildsocketapidev.appskeeper.in';
  static String qaBaseUrl = 'https://cobuildsocketapiqa.appskeeper.in';
  static String stageBaseUrl = 'https://preprod-socket.cobuildapp.net/';
  static String productionBaseUrl = 'https://prod-socket.cobuildapp.net/';
}

abstract class DeepLinkBaseUrl {
  static String devBaseUrl = 'https://cobuildapp-alternate.app.link';
  static String qaBaseUrl = 'https://cobuildapp-alternate.app.link';
  static String stageBaseUrl = 'https://cobuildapp-alternate.app.link';
  static String productionBaseUrl = 'https://cobuildapp.app.link';
}

abstract class AdminBaseUrl {
  static String devBaseUrl =
      "https://cobuild-dev-admin.appskeeper.in/cms-management-public";
  static String qaBaseUrl =
      "https://cobuild-qa-admin.appskeeper.in/cms-management-public";
  static String stageBaseUrl =
      "https://preprod-admin.cobuildapp.net/cms-management-public";
  static String productionBaseUrl =
      "https://prod-admin.cobuildapp.net/cms-management-public";
}

abstract class S3ImageBaseUrl {
  static String devBaseUrl = "https://cobuild-media.appskeeper.in/";
  static String qaBaseUrl = "https://cobuild-media.appskeeper.in/";
  static String stagingBaseUrl = "https://preprod-media.cobuildapp.net/";
  static String prodBaseUrl = "https://prod-media.cobuildapp.net/";
}

abstract class ApiKeys {
  static const String getMethod = 'GET';
  static const String postMethod = 'POST';
  static const String contentType = 'Content-Type';
  static const String apiKey = 'api_key';
  static const String applicationJson = 'application/json';
  static const String formData = 'multipart/form-data';
  static const String authorization = 'authorization';
  static const String accept = 'Accept';
  static const String userAgent = 'User-Agent';
  static const String formUrlEncoded = 'application/x-www-form-urlencoded';
  static const String fields = 'fields';
  static const String files = 'files';
  static const String error = 'error';
  static const String msg = 'msg';
  static const String status = 'status';
  static const String statusCode = 'statusCode';
  static const String message = 'message';
  static const String data = 'data';
  static const String bearer = 'Bearer';
  static const String basic = 'Basic';
  static const String deviceid = 'deviceId';
  static const String devicetoken = 'deviceToken';
  static const String platform = 'platform';
  static const String language = 'language';

  /// Api keys
  static const String email = 'email';
  static const String password = 'password';
  static const String pageNo = 'pageNo';
  static const String limit = 'limit';
  static const String type = 'type';
  static const String nextHit = 'nextHit';
  static const String searchKey = 'searchKey';
  static const String jobId = "jobId";
  static const String coordinatesLongitude = "coordinatesLongitude";
  static const String coordinatesLatitude = "coordinatesLatitude";
  static const String coordinates = "coordinates";
  static const String priority = "priority";
  static const String sortOrder = "sortOrder";
  static const String sortBy = "sortBy";
  static const String serviceCategory = "serviceCategory";
  static const String total = "total";
  static const String reqId = "reqId";
  static const String isCompleted = "isCompleted";
  static const String isActive = "isActive";
  static const String fileType = "fileType";
  static const String filename = "filename";
  static const String url = "url";
  static const String serviceType = "serviceType";
  static const String notificationIds = "notificationIds";
  static const String notificationId = "notificationId";
  static const String chatId = "chatId";
  static const String localMessageId = "localMessageId";
  static const String messageType = "messageType";
  static const String senderId = "senderId";
  static const String reportId = "reportId";
  static const String deleteAccount = "deleteAccount";
}

class AppKeys {
  static const String model = 'model';
  static const String id = 'id';
  static const String path = 'path';
  static const String url = 'url';
  static const String initCoordinates = 'initCoordinates';
  static const String file = 'file';
  static const String initialIndex = 'initialIndex';
  static const String googlePlaceAPIKey =
      "AIzaSyBQWX1k1u2KHKEn4LNaKcM9V_vYG6dLQd4";
}

abstract class SocketKeys {
  static String socketUrl = "${HttpHelper().socketBaseUrl}?accessToken=";
  // End points
  static String inboxListing = "__inbox_chat";
  static String enterChatRoom = "__one_to_one";
  static String getMessagesList = "__inbox_message";
  static String leftChatRoom = "__chat_room_left";
  static String authError = "authorization-error";
  static String socketConnected = "connected";
  static String sendMsg = "__one_to_one_chat_message";
  static String quotationReply = "__quotation_status";
  static String unReadNotify = "__unread_notify";
  static String refreshInbox = "__refresh_inbox";
  static String chatReadStatus = "__chat_read_status";
  static String rejectRequest = "__reject_request";
  static String getJobChatId = "__job_chat_formation";
  // Keys :-
  static String chatId = "chatId";
  static String jobId = "jobId";
  static String eventType = "eventType";
  static String lastMsgId = "lastMsgId";
  static const String unread = "unread";
  // Unused
  static String markReadAll = "__marked_read_all";
  static String receiveMsg = "__receive_message";
  static const String transports = "transports";
  static const String typingUpdate = "__live_tracking";
  static const String socketType = "websocket";

  static const String pageNo = "pageNo";
  static const String limit = "limit";
  static const String status = "status";
  static const String searchKey = "searchKey";
}

class AppCreds {
  static const String apiUsername = 'cobuild';
  static const String apiPassword = 'cobuild@123';
  static const String apiKey = '1234';
}

abstract class ApiStatusCode {
  static const sessionExpired = 401;
  static const socketSuccessResponse = 200;
}

class ErrorCases {
  static List<String> allErrors = ['INVALID_OTP'];
  static String sessionExpired = "SESSION_EXPIRED";
  static String emailNotFoundInAppleLogin = "SOCIAL_EMAIL_NOT_FOUND";
}
