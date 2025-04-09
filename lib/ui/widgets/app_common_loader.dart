import 'package:cobuild/global/global.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Common loader used in app
class CommonLoader extends StatelessWidget {
  final Color color;
  final double? size;
  final bool isButtonLoader;
  const CommonLoader(
      {super.key,
      this.color = AppColors.white,
      this.size,
      this.isButtonLoader = false});

  @override
  Widget build(BuildContext context) {
    if (isButtonLoader) {
      return CupertinoActivityIndicator(color: color, radius: size ?? 11.25.sp);
    }
    return CupertinoActivityIndicator(
        color: AppColors.primaryColor, radius: size ?? 22.sp);
  }
}

class NextPageDataLoader extends StatelessWidget {
  const NextPageDataLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: KEdgeInsets.k(v: fieldGap, h: 20.w),
      child: const LinearProgressIndicator(),
    );
  }
}
