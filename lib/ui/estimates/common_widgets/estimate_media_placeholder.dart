import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

class EstimateMediaPlaceholder extends StatelessWidget {
  const EstimateMediaPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.h,
      padding: EdgeInsets.all(20.h),
      alignment: Alignment.center,
      child: const ShowImage(
        image: AppImages.estimatePlaceHolder,
        type: ImageType.local,
      ),
    );
  }
}
