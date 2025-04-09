import 'package:cobuild/ui/components/common_widgets.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:go_router/go_router.dart';

class JobSearchAndFilterWidget extends StatelessWidget {
  final bool isHomePage;
  const JobSearchAndFilterWidget({super.key, this.isHomePage = true});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: InkWell(
          onTap: () {
            context.pushNamed(AppRoutes.searchJobs);
          },
          child: Container(
            padding: KEdgeInsets.k(v: 12.h, h: 14.w),
            height: 48.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.white),
            child: Row(
              children: [
                CommonWidgets.searchIcon(),
                Gap(14.w),
                Title1(title: S.current.searchJobs)
              ],
            ),
          ),
        ),
      ),
      Gap(8.w),
      Container(
        height: 48.h,
        width: 48.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: isHomePage
                ? AppColors.lightOrangeColor
                : AppColors.primaryColor),
        child: InkWell(
            onTap: () {
              context.pushNamed(AppRoutes.filterJobs);
            },
            child:
                ShowImage(image: AppImages.filter, height: 24.h, width: 24.h)),
      )
    ]);
  }
}
