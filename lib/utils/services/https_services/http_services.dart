import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/app_controller/app_bloc.dart';
import 'package:cobuild/bloc/controller/app_controller/app_event.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/services/https_services/http_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';

/// Api calling using Http
class HttpServices extends HttpHelper {
  DateTime? lastNoInternetMessageTime;
  DateTime? lastSessionExpiredMessageTime;
  static final HttpServices _instance = HttpServices._internal();
  Map<String, String> headers = {};

  HttpServices._internal();

  factory HttpServices() => _instance;

  /// common interface for all api requests
  Future<BlocResponse> apiRequest(ApiRequest request, BlocEvent event,
      {Map<String, dynamic>? body,
      ApiContentType contentType = ApiContentType.json,
      Map<String, dynamic>? queryParams,
      required String apiEndPoint,
      int? statusCode,
      ApiAuthType authType = ApiAuthType.accessToken,
      bool addDeviceId = false}) async {
    var uri = createURL(request, apiEndPoint, queryParams);
    if (contentType == ApiContentType.formData) {
      headers = await getHeaders(ApiContentType.formData, authType: authType);
    } else {
      headers = await getHeaders(ApiContentType.json, authType: authType);
    }
    if (addDeviceId && (body?.isNotEmpty ?? false)) {
      body?.addAll({
        ApiKeys.deviceid: AppPreferences.deviceId,
        ApiKeys.devicetoken: AppPreferences.deviceToken
      });
    }

    if (body?.isNotEmpty ?? false) {
      body?.removeWhere((key, value) => value == null);
    }

    final startTime = DateTime.now();

    if (kDebugMode) {
      log('------------------------------------------');

      log('START TIME: ${startTime.hour} : ${startTime.minute} : ${startTime.second}');
      log('URL: $uri');
      log('METHOD: ${request == ApiRequest.apiPost ? 'POST' : request == ApiRequest.apiPut ? 'PUT' : request == ApiRequest.apiPatch ? 'PATCH' : request == ApiRequest.apiDelete ? 'DELETE' : 'GET'}');
      log('HEADERS: $headers');
    }

    //try api requests
    try {
      String responseBody;
      if (contentType == ApiContentType.formData) {
        var response = await formDataRequest(
          uri,
          request,
          headers,
          body,
        );
        statusCode = response.statusCode;
        responseBody = response.body;
      } else {
        log('BODY: ${json.encode(body)}');
        http.Response response;
        switch (request) {
          case ApiRequest.apiGet:
            response = await getRequest(uri, headers);
            break;
          case ApiRequest.apiPost:
            if (contentType == ApiContentType.formUrlEncoded) {
              response = await postRequest(uri, headers, body!);
            } else {
              response = await postRequest(uri, headers, body ?? {});
            }
            break;
          case ApiRequest.apiPut:
            response = await putRequest(uri, headers, body!);
            break;
          case ApiRequest.apiPatch:
            response = await patchRequest(uri, headers, body!);
            break;
          case ApiRequest.apiDelete:
            response = await deleteRequest(uri, headers, body!);
            break;
          default:
            return BlocResponse(
              state: BlocState.failed,
              event: event,
              message: '',
            );
        }

        statusCode = response.statusCode;
        responseBody = response.body;
      }

      if (kDebugMode) {
        log('TIME TAKEN: ${DateTime.now().difference(startTime).inMilliseconds} Miliseconds');
        log('URL: $uri');
        log('STATUS CODE: $statusCode');
        log('RESPONSE: $responseBody');
      }
      var res = json.decode(responseBody);
      if ((res != null) && (res[ApiKeys.type] == ErrorCases.sessionExpired)) {
        if (ctx.mounted) {
          String sessionExpiredMessage =
              res[ApiKeys.message] ?? res[ApiKeys.msg] ?? '';
          _showSessionExpiredMessage(sessionExpiredMessage);
          ctx.read<AppController>().add(LogoutEvent(callApi: false));
          return BlocResponse(state: BlocState.failed, event: event);
        }
      }
      if (((res[ApiKeys.statusCode] != null) &&
              (res[ApiKeys.statusCode] >= 400)) ||
          (statusCode >= 400)) {
        String msg = '';
        if ((res[ApiKeys.msg] is List) && (res[ApiKeys.msg].isNotEmpty)) {
          msg = res[ApiKeys.msg][0];
        } else {
          msg = res[ApiKeys.message] ??
              res[ApiKeys.msg] ??
              res[ApiKeys.data] ??
              '';
        }
        if (msg.length > 200) msg = S.current.somethingWentWrong;
        if (msg.isNotEmpty && !(ErrorCases.allErrors.contains(res['type']))) {
          showSnackBar(message: msg);
        }
        return BlocResponse(
          state: BlocState.failed,
          event: event,
          message: msg,
          data: res,
          statusCode: statusCode,
        );
      }
      return BlocResponse(
        state: BlocState.success,
        event: event,
        data: res,
        statusCode: statusCode,
      );
    } on SocketException {
      _showNoInternetMessage();
      return BlocResponse(
        state: BlocState.noInternet,
        event: event,
        message: '',
      );
    } on HandshakeException {
      _showNoInternetMessage();
      return BlocResponse(
        state: BlocState.noInternet,
        event: event,
        message: '',
      );
    } on TimeoutException {
      _showNoInternetMessage();
      return BlocResponse(
        state: BlocState.noInternet,
        event: event,
        message: '',
      );
    } catch (e) {
      printPersistent('error $e');
      String error;
      if (e.toString().length > 60) {
        error = S.current.somethingWentWrong;
      } else {
        error = e.toString();
      }
      return BlocResponse(
          state: BlocState.failed,
          event: event,
          message: error,
          exceptionType: e.runtimeType,
          statusCode: statusCode);
    } finally {
      if (kDebugMode) {
        log('---------------------------------------');
      }
    }
  }

  /// return basic or auth headers
  Future<Map<String, String>> getHeaders(ApiContentType contentType,
      {bool isCsv = false, required ApiAuthType authType}) async {
    // final accessToken = await AppSecureStorage()
    //     .readSecureString(AppSecureStorageKeys.accessToken);
    String? accessToken = AppPreferences().getUserToken();
    final encodedVal = base64
        .encode(utf8.encode('${AppCreds.apiUsername}:${AppCreds.apiPassword}'));
    String basicAuth = '${ApiKeys.basic} $encodedVal';
    final header = {
      ApiKeys.apiKey: AppCreds.apiKey,
      ApiKeys.contentType: (contentType == ApiContentType.json)
          ? ApiKeys.applicationJson
          : ApiKeys.formData,
      if (isCsv) ApiKeys.accept: 'application/json',
      ApiKeys.authorization:
          accessToken.isNotEmpty ? "Bearer $accessToken" : basicAuth,
      ApiKeys.language: selectedLanguage,
      ApiKeys.platform: Platform.isAndroid ? '1' : '2',
    };
    return header;
  }

  String generateRandomString() {
    var r = math.Random();
    return String.fromCharCodes(
        List.generate(5, (index) => r.nextInt(33) + 89));
  }

  _showNoInternetMessage() {
    DateTime currentTime = DateTime.now();
    if (lastNoInternetMessageTime == null ||
        currentTime
                .difference(lastNoInternetMessageTime ?? currentTime)
                .inSeconds >
            15) {
      lastNoInternetMessageTime = currentTime;
      showSnackBar(message: S.current.noInternet);
    }
  }

  _showSessionExpiredMessage(String? message) {
    DateTime currentTime = DateTime.now();
    if (lastSessionExpiredMessageTime == null ||
        currentTime
                .difference(lastSessionExpiredMessageTime ?? currentTime)
                .inSeconds >
            15) {
      lastSessionExpiredMessageTime = currentTime;
      showSnackBar(message: message ?? S.current.somethingWentWrong);
    }
  }
}

enum ApiAuthType {
  basicAuth,
  accessToken,
  refreshToken;

  bool get isBasicAuth => this == basicAuth;
  bool get isAccessToken => this == accessToken;
  bool get isRefreshToken => this == refreshToken;
}
