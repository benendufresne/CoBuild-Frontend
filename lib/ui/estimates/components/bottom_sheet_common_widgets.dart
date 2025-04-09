import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:go_router/go_router.dart';

// Commmon bottom sheet to select option while creating estimate
class CommonSelectableBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  const CommonSelectableBottomSheet(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth,
      padding: EdgeInsets.fromLTRB(
          20.w, 16.h, 24.w, MediaQuery.of(context).viewInsets.bottom + 30.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Header2(heading: title, fontSize: 18)),
                IconButton(
                  icon: const ShowImage(image: AppImages.crossIcon),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
            Gap(fieldGap / 2),
            child,
          ],
        ),
      ),
    );
  }
}
