import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Common back button
class AppCommonBackButton extends StatelessWidget {
  const AppCommonBackButton({
    super.key,
    this.color = AppColors.black,
    this.padding,
    this.size,
    this.image,
  });

  final EdgeInsetsGeometry? padding;
  final Color color;
  final double? size;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: padding,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: ShowImage(
          image: image ?? AppImages.backButton,
          color: color,
          height: size ?? 18.sp,
          width: size ?? 10.sp,
        ));
  }
}
