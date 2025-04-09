class UploadMediaModel {
  UploadMediaModel(
      {required this.presignedUrl,
      required this.filePath,
      required this.fileType});
  String presignedUrl, fileType, filePath;
}
