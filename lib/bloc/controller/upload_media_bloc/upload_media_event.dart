import 'dart:io';

import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class UploadMediaEvents extends BlocEvent {
  const UploadMediaEvents();
}

class UploadMediaInitialEvent extends UploadMediaEvents {
  const UploadMediaInitialEvent();
}

/// Get Url to upload media
class UploadMediaToServerEvent extends UploadMediaEvents {
  final File file;
  String? fileName, fileType;
  UploadMediaToServerEvent({this.fileName, this.fileType, required this.file});
}
