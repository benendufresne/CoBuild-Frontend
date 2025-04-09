import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:cobuild/ui/components/jobs/job_card_title_image.dart';
import 'package:cobuild/ui/components/jobs/job_common_components.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/job_enums.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Common Job card
class JobCard extends StatelessWidget {
  final JobModel model;
  const JobCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoutes.jobDetails, extra: {AppKeys.id: model.sId});
      },
      child: Stack(
        children: [
          Container(
            width: deviceWidth,
            padding: KEdgeInsets.k(h: 14.w, v: 16.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Logo  , Job Title And DEscription
                Row(
                  children: [
                    const JobCardTitleImage(),
                    Gap(12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.title ?? '',
                            style: AppStyles().regularBolder),
                        Text(model.categoryName ?? '',
                            style: AppStyles()
                                .regularSemiBold
                                .colored(AppColors.black.withOpacity(0.5)))
                      ],
                    )
                  ],
                ),
                Gap(16.h),
                Row(
                  children: [
                    ShowImage(
                      image: AppImages.locationIconGreen,
                      height: 21.h,
                    ),
                    Gap(9.w),
                    Expanded(
                        child: Text(model.location?.address ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles().regularBold)),
                    Gap(9.w),
                    Text(JobCommonComponents.jobPostTime(model),
                        style: AppStyles()
                            .regularSemiBold
                            .colored(AppColors.black.withOpacity(0.5)))
                  ],
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 16.h,
            child: _jobStatus(),
          )
        ],
      ),
    );
  }

  Widget _jobStatus() {
    return Container(
      padding: KEdgeInsets.k(v: 6.h, h: 12.5.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.r),
            bottomLeft: Radius.circular(4.r),
          ),
          color: AppColors.primaryColor),
      child: Text(
        getJobStatusNameFromEnum(model.status ?? ''),
        style: AppStyles().smallBold.colored(AppColors.white),
      ),
    );
  }
}
