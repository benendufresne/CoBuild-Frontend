enum NotificaionTypeEnum {
  profileUpdated,
  damageReportStatusUpdate,
  estimateRequestAccepted,
  estimateRequestRejected,
  none;

  static NotificaionTypeEnum parse(String? value) {
    switch (value) {
      case "PROFILE_UPDATED_SUCCESSFULLY":
        return NotificaionTypeEnum.profileUpdated;
      case "DAMAGE_REQUEST_UPDATE":
        return NotificaionTypeEnum.damageReportStatusUpdate;
      case "ESTIMATE_REQUEST_ACCEPTED_USER":
        return NotificaionTypeEnum.estimateRequestAccepted;
      case "ESTIMATE_REQUEST_REJECTED_USER":
        return NotificaionTypeEnum.estimateRequestRejected;
      default:
        return NotificaionTypeEnum.none;
    }
  }
}
