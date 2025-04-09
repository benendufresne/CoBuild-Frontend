import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

// Show status of Estimate
class EstimateRequestStatus extends StatelessWidget {
  final EstimateRequestModel model;

  const EstimateRequestStatus({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    Color color = getColor;
    return Container(
      padding: KEdgeInsets.k(h: 8.w, v: 5.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: color.withOpacity(0.1)),
      child: Text(
        statusText,
        style: AppStyles().sExtraSmallwBolder.colored(color),
      ),
    );
  }

  Color get getColor {
    switch (getEstimateEnumFromBackendValue(model.status ?? '')) {
      case EstimatesStatusEnum.pending:
        return AppColors.pendingStatusColor;
      case EstimatesStatusEnum.approved:
        return AppColors.approvedStatusColor;
      case EstimatesStatusEnum.rejected:
        return AppColors.rejectedStatusColor;
      case EstimatesStatusEnum.deleted:
        return AppColors.rejectedStatusColor;
      case EstimatesStatusEnum.inprogress:
        return AppColors.inProgressStatusColor;
      case EstimatesStatusEnum.completed:
        return AppColors.approvedStatusColor;
    }
  }

  String get statusText {
    return getEstimateEnumFromBackendValue(model.status ?? '')
        .enumValue
        .displayName;
  }
}
