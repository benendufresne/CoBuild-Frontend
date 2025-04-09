enum MediaTypeEnum { image, pdf, doc }

extension MediaTypeEnumExtension on MediaTypeEnum {
  String get name {
    switch (this) {
      case MediaTypeEnum.image:
        return 'image';
      case MediaTypeEnum.pdf:
        return 'pdf';
      case MediaTypeEnum.doc:
        return 'doc';
    }
  }
}

MediaTypeEnum getMediaType(String? mimeType) {
  switch (mimeType) {
    case "application/pdf":
      return MediaTypeEnum.pdf;
    case "application/msword":
      return MediaTypeEnum.doc;
    default:
      return MediaTypeEnum.image;
  }
}
