import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

// Common list tile
class CommonTile extends StatelessWidget {
  final String icon;
  final String label;
  final double? margin;
  final Function? onTap;

  const CommonTile(
      {super.key,
      required this.icon,
      required this.label,
      this.margin,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          child: Container(
            padding: KEdgeInsets.k16,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.white),
            child: Row(
              children: [
                ShowImage(
                  image: icon,
                  height: 24.sp,
                  width: 24.sp,
                ),
                Gap(12.w),
                Text(label,
                    style: AppStyles().regularSemiBold.colored(AppColors.black))
              ],
            ),
          ),
        ),
        Gap(fieldGap),
      ],
    );
  }
}
