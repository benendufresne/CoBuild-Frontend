import 'package:cobuild/models/enum_model/common_enum_model.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';

/// Filters
enum JobFilterTypes { status, serviceCategory, sortBy, priority }

extension JobFilterTypeVales on JobFilterTypes {
  String get displayName {
    switch (this) {
      case JobFilterTypes.status:
        return S.current.status;
      case JobFilterTypes.serviceCategory:
        return S.current.serviceCategory;
      case JobFilterTypes.sortBy:
        return S.current.sortBy;
      case JobFilterTypes.priority:
        return S.current.priority;
    }
  }
}

enum PriorityEnum { high, medium, low }

extension PriorityEnumValues on PriorityEnum {
  EnumModel get enumValue {
    switch (this) {
      case PriorityEnum.high:
        return EnumModel(displayName: S.current.high, backendName: "HIGH");
      case PriorityEnum.medium:
        return EnumModel(displayName: S.current.medium, backendName: "MEDIUM");
      case PriorityEnum.low:
        return EnumModel(displayName: S.current.low, backendName: "LOW");
    }
  }
}

enum SortByEnum { desc, asc }

extension SortByEnumValues on SortByEnum {
  String get displayName {
    switch (this) {
      case SortByEnum.asc:
        return S.current.ascendingOrder;
      case SortByEnum.desc:
        return S.current.descendingOrder;
    }
  }

  int get backendEnum {
    switch (this) {
      case SortByEnum.asc:
        return 1;
      case SortByEnum.desc:
        return -1;
    }
  }
}

enum StatusEnum { scheduled, inprogress, completed, canceled }

// Backend Enums :-

const String scheduled = "SCHEDULED";
const String inProgress = "IN_PROGRESS";
const String completed = "COMPLETED";
const String canceled = "CANCELED";

extension StatusEnumValues on StatusEnum {
  EnumModel get enumValue {
    switch (this) {
      case StatusEnum.scheduled:
        return EnumModel(
            displayName: S.current.scheduled, backendName: scheduled);
      case StatusEnum.inprogress:
        return EnumModel(
            displayName: S.current.inprogress, backendName: inProgress);
      case StatusEnum.completed:
        return EnumModel(
            displayName: S.current.completed, backendName: completed);
      case StatusEnum.canceled:
        return EnumModel(
            displayName: S.current.canceled, backendName: canceled);
    }
  }
}

String getJobStatusNameFromEnum(String backendEnum) {
  switch (backendEnum) {
    case scheduled:
      return S.current.scheduled;
    case inProgress:
      return S.current.inprogress;
    case completed:
      return S.current.completed;
    case canceled:
      return S.current.canceled;
    default:
      return S.current.scheduled;
  }
}
