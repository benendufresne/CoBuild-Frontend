import 'dart:io';

import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/upload_media_bloc/upload_media_event.dart';
import 'package:cobuild/bloc/repositories/app_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/upload_media/upload_media_model.dart';
import 'package:cobuild/utils/api_endpoints.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/services/https_services/http_services.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

abstract class UploadMediaRepository extends AppRepository {
  static _UploadMediaRepositoryImpl? _instance;

  factory UploadMediaRepository() {
    return _instance ??= _UploadMediaRepositoryImpl();
  }

  Future<BlocResponse> uploadMedia(UploadMediaToServerEvent event);
}

class _UploadMediaRepositoryImpl implements UploadMediaRepository {
  final HttpServices _apiService = HttpServices();

  @override
  Future<BlocResponse> uploadMedia(UploadMediaToServerEvent event) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileExtension =
        event.file.path.split('.').last; // Extract the file extension
    final fileNameWithoutExtension = event.file.path
        .split('/')
        .last
        .split('.')
        .first; // Extract the file name without extension
    final uniqueFileName =
        "$fileNameWithoutExtension-$timestamp.$fileExtension";
    event.fileName = uniqueFileName;
    event.fileType = lookupMimeType(event.file.path);
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.getMediaUrl,
        queryParams: {
          ApiKeys.filename: event.fileName,
          ApiKeys.fileType: event.fileType
        },
        body: {});
    if (response.state == BlocState.success) {
      String presignedUrl = response.data[ApiKeys.data][ApiKeys.url] ?? '';
      bool isUploaded = await uploadMediaRequest(
        UploadMediaModel(
            presignedUrl: presignedUrl,
            filePath: event.file.path,
            fileType: event.fileType ?? ''),
      );
      event.fileName = "${baseUrlModel.mediaBaseUrl}${event.fileName}";
      return BlocResponse(
          event: event,
          state: isUploaded ? BlocState.success : BlocState.failed);
    } else {
      return BlocResponse(event: event, state: BlocState.failed);
    }
  }

  // Upload Media
  Future<bool> uploadMediaRequest(UploadMediaModel model) async {
    try {
      final file = File(model.filePath);
      // Ensure the file exists before proceeding
      if (!file.existsSync()) {
        return false;
      }
      final fileLength = await file.length();
      final fileBytes = await file.readAsBytes();
      // Set headers, including Content-Length to disable Transfer-Encoding
      final uploadHeaders = {
        HttpHeaders.contentTypeHeader: model.fileType,
        HttpHeaders.contentLengthHeader: fileLength.toString(),
      };
      // Perform the PUT request
      final http.Response response = await http.put(
        Uri.parse(model.presignedUrl),
        body: fileBytes,
        headers: uploadHeaders,
      );
      // Check if the status code indicates success
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        showSnackBar(message: S.current.somethingWentWrong);
        return false;
      }
    } catch (e) {
      // Handle any exceptions during the upload process
      showSnackBar(message: S.current.somethingWentWrong);
      return false;
    }
  }

  ///clear data on logout
  @override
  Future<void> clearDataOnLogout() async {}
}
