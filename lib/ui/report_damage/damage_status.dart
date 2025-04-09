import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/report_damage_enum.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Damage report status
class DamageReportStatus extends StatelessWidget {
  final DamageModel model;

  const DamageReportStatus({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    Color color = getColor;
    return Container(
      padding: KEdgeInsets.k(h: 8.w, v: 5.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: color.withOpacity(0.1)),
      child: Text(statusText,
          style: AppStyles().sExtraSmallwBolder.colored(color)),
    );
  }

  Color get getColor {
    switch (getDamageReportStatusEnumFromBackendValue(model.status ?? '')) {
      case DamageReporttatusEnum.pending:
        return AppColors.pendingStatusColor;
      case DamageReporttatusEnum.completed:
        return AppColors.approvedStatusColor;
    }
  }

  String get statusText {
    return getDamageReportStatusEnumFromBackendValue(model.status ?? '')
        .enumValue
        .displayName;
  }
}
