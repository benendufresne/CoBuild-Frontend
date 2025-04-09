import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

// Common Floating Button used in app

class CommonFloatingButton extends StatelessWidget {
  final Function onPressed;
  const CommonFloatingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 52.h,
        width: 52.h,
        padding: KEdgeInsets.k14,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.r),
            color: AppColors.primaryColor),
        child: ShowImage(
          image: AppImages.addIcon,
          height: 24.h,
          width: 24.h,
        ),
      ),
    );
  }
}
