import 'package:cobuild/models/enum_model/common_enum_model.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';

/// Backend values
const String pending = "PENDING";
const String completed = "COMPLETED";

enum DamageReporttatusEnum { pending, completed }

extension DamageReporttatusEnumValues on DamageReporttatusEnum {
  EnumModel get enumValue {
    switch (this) {
      case DamageReporttatusEnum.pending:
        return EnumModel(displayName: S.current.pending, backendName: pending);
      case DamageReporttatusEnum.completed:
        return EnumModel(
            displayName: S.current.completed, backendName: completed);
    }
  }
}

DamageReporttatusEnum getDamageReportStatusEnumFromBackendValue(String value) {
  switch (value) {
    case pending:
      return DamageReporttatusEnum.pending;
    case completed:
      return DamageReporttatusEnum.completed;
    default:
      return DamageReporttatusEnum.pending;
  }
}
