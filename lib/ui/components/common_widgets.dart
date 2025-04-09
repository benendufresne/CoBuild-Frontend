import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:flutter/widgets.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Common app components
class CommonWidgets {
  static Widget searchIcon() {
    return ShowImage(
      image: AppImages.searchIcon,
      height: 24.h,
      width: 24.h,
    );
  }

  static Widget locationIcon() {
    return ShowImage(
      image: AppImages.locationIconGreen,
      color: AppColors.lightGreyText,
      height: 24.h,
      width: 24.h,
    );
  }
}
