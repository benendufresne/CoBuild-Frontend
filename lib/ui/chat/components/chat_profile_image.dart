import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Profile image view for chat tile
class ChatProfileImage extends StatelessWidget {
  const ChatProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.h,
        width: 40.h,
        padding: KEdgeInsets.k8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.h),
            color: AppColors.primaryColor),
        child: const ShowImage(image: AppImages.logoWhite));
  }
}
