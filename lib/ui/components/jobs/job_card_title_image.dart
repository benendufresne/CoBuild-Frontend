import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Job card Title Image
class JobCardTitleImage extends StatelessWidget {
  const JobCardTitleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      width: 38.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: AppColors.lightBlue),
      padding: EdgeInsets.all(7.h),
      child: const ShowImage(
        image: AppImages.jobCardPlaceHolder,
        type: ImageType.local,
      ),
    );
  }
}
