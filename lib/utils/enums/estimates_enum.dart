import 'package:cobuild/models/enum_model/common_enum_model.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';

/// Backend values
const String pending = "PENDING";
const String deleted = "DELETED";
const String inProgress = "IN_PROGRESS";
const String approved = "APPROVED";
const String rejected = "REJECTED";
const String completed = "COMPLETED";

enum EstimatesStatusEnum {
  pending,
  approved,
  rejected,
  deleted,
  inprogress,
  completed
}

extension EstimatesStatusEnumValues on EstimatesStatusEnum {
  EnumModel get enumValue {
    switch (this) {
      case EstimatesStatusEnum.pending:
        return EnumModel(displayName: S.current.pending, backendName: pending);
      case EstimatesStatusEnum.deleted:
        return EnumModel(displayName: S.current.deleted, backendName: deleted);
      case EstimatesStatusEnum.inprogress:
        return EnumModel(
            displayName: S.current.inprogress, backendName: inProgress);
      case EstimatesStatusEnum.approved:
        return EnumModel(
            displayName: S.current.approved, backendName: approved);
      case EstimatesStatusEnum.rejected:
        return EnumModel(
            displayName: S.current.rejected, backendName: rejected);
      case EstimatesStatusEnum.completed:
        return EnumModel(
            displayName: S.current.completed, backendName: completed);
    }
  }
}

EstimatesStatusEnum getEstimateEnumFromBackendValue(String value) {
  switch (value) {
    case pending:
      return EstimatesStatusEnum.pending;
    case deleted:
      return EstimatesStatusEnum.deleted;
    case inProgress:
      return EstimatesStatusEnum.inprogress;
    case approved:
      return EstimatesStatusEnum.approved;
    case rejected:
      return EstimatesStatusEnum.rejected;
    case completed:
      return EstimatesStatusEnum.completed;
    default:
      return EstimatesStatusEnum.pending;
  }
}

/// Service Type
enum ServiceTypeEnum { categoryService, customService, cableConsultingService }

/// Backend values
const String categoryService = "Category Service";
const String customService = "Custom Service";
const String cableConsultingService = "Cable Consulting Service";

extension ServiceTypeEnumValues on ServiceTypeEnum {
  EnumModel get enumValue {
    switch (this) {
      case ServiceTypeEnum.categoryService:
        return EnumModel(
            displayName: S.current.categoryService,
            backendName: categoryService);
      case ServiceTypeEnum.customService:
        return EnumModel(
            displayName: S.current.customService, backendName: customService);
      case ServiceTypeEnum.cableConsultingService:
        return EnumModel(
            displayName: S.current.cableConsultingService,
            backendName: cableConsultingService);
    }
  }
}

ServiceTypeEnum getServiceTypeEnumFromBackendValue(String? value) {
  switch (value) {
    case categoryService:
      return ServiceTypeEnum.categoryService;
    case customService:
      return ServiceTypeEnum.customService;
    case cableConsultingService:
      return ServiceTypeEnum.cableConsultingService;
    default:
      return ServiceTypeEnum.categoryService;
  }
}

// Used for api calling
enum ServiceCategoryType {
  categoryService,
  cableConsulting,
  cableConsultingSubType
}
