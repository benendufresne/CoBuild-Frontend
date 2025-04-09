import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/ui/components/text/title3.dart';
import 'package:cobuild/ui/widgets/app_common_widgets.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

// Common widgets
class CommonBottomSheetWidgets {
  static Widget commonDivider() {
    return AppCommonDivider(
      color: AppColors.black.withOpacity(0.07),
    );
  }

  static Widget option(String type) {
    return Padding(
        padding: KEdgeInsets.k(v: 20.h),
        child: Title3(title: type, align: TextAlign.start));
  }

  /// Main Service Type
  static String serviceType(EstimateRequestModel model) {
    return getServiceTypeEnumFromBackendValue(model.serviceType)
        .enumValue
        .displayName;
  }

  static String serviceSubType(EstimateRequestModel model) {
    return model.categoryName ?? '';
  }
}
