import 'dart:convert';
import 'dart:io';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:cobuild/utils/enums/app_enums.dart';

/// Base class to handle api calling
class HttpHelper {
  /// get the base url acc. to running mode
  String get _baseUrl => baseUrlModel.apiBaseUrl;

  String get socketBaseUrl => baseUrlModel.socketBaseUrl;

  /// convert the url string to URI
  /// appends query params to the url
  Uri createURL(ApiRequest request, String apiEndPoint,
      Map<String, dynamic>? queryParams) {
    String url;
    url = '$_baseUrl$apiEndPoint';
    // append query params to url
    if (request == ApiRequest.apiGet && queryParams != null) {
      var count = 0;
      queryParams.forEach((key, value) {
        if (count == 0) {
          url += '?';
        }
        url += '$key=$value';
        if (count < queryParams.length - 1) {
          url += '&';
        }
        count++;
      });
    }
    debugPrint(url);
    return Uri.parse(url);
  }

  /// to send get api request
  Future<http.Response> deleteRequest(
    Uri uri,
    Map<String, String> headersData,
    Map<String, dynamic> body,
  ) async {
    final client = http.Client();
    var response = await client.send(http.Request('DELETE', uri)
      ..headers.addAll(headersData)
      ..body = jsonEncode(body));
    return http.Response.fromStream(response).timeout(apiTimeOut);
  }

  /// to send form-data
  Future<http.Response> formDataRequest(
    Uri uri,
    ApiRequest method,
    Map<String, String> headers,
    Map<String, dynamic>? body,
  ) async {
    var formData = await _fileConversion(body ?? {});
    var request = http.MultipartRequest(
        (method == ApiRequest.apiPost) ? ApiKeys.postMethod : ApiKeys.getMethod,
        uri)
      ..fields.addAll(formData[ApiKeys.fields])
      ..files.addAll(formData[ApiKeys.files])
      ..headers.addAll(headers);
    var res = await request.send().timeout(apiTimeOut);
    final response = await http.Response.fromStream(res);
    return response;
  }

  /// to send get api request
  Future<http.Response> getRequest(
    Uri uri,
    Map<String, String> headers,
  ) async {
    return await http.get(uri, headers: headers).timeout(apiTimeOut);
  }

  /// to send post api request
  Future<http.Response> patchRequest(
    Uri uri,
    Map<String, String> headers,
    Map<String, dynamic> body,
  ) async {
    return await http
        .patch(uri, headers: headers, body: json.encode(body))
        .timeout(apiTimeOut);
  }

  /// to send post api request
  Future<http.Response> putRequest(
    Uri uri,
    Map<String, String> headers,
    Map<String, dynamic> body,
  ) async {
    return await http
        .put(uri, headers: headers, body: json.encode(body))
        .timeout(apiTimeOut);
  }

  /// to send post api request
  Future<http.Response> postRequest(
      Uri uri, Map<String, String> headers, Map<String, dynamic> body,
      {Duration? timeoutDuration}) async {
    return await http
        .post(uri, headers: headers, body: json.encode(body))
        .timeout(timeoutDuration ?? apiTimeOut);
  }

  /// to convert files to multipart-files for uploading
  Future<Map<String, dynamic>> _fileConversion(
    Map<String, dynamic> body,
  ) async {
    var keysList = body.keys.toList();
    var fields = <String, String>{};
    var files = List<http.MultipartFile>.empty(growable: true);

    for (var key in keysList) {
      if (body[key] is File) {
        files.add(await http.MultipartFile.fromPath(key, body[key].path,
            contentType: MediaType.parse('audio/mpeg')));
      } else if (body[key] is List<File>) {
        for (var value in body[key]) {
          files.add(await http.MultipartFile.fromPath(key, value.path));
        }
      } else {
        fields[key] = body[key].toString();
      }
    }
    return {ApiKeys.fields: fields, ApiKeys.files: files};
  }
}
