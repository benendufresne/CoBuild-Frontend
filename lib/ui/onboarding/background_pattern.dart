import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Backgroun pattern used in :- Login and signup screen top of the page
extension TopLogo on Widget {
  Widget get topRightLogo => Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: ShowImage(
              image: AppImages.backgroundPattern,
              height: 200.h,
              width: 255.w,
            ),
          ),
          SafeArea(
            bottom: false,
            child: this,
          ),
        ],
      );
}
