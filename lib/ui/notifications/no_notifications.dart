import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Empty notification view
class NoNotifications extends StatelessWidget {
  const NoNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShowImage(
            image: AppImages.emptyNotificationImage,
            height: 115.h,
            width: 105.w,
          ),
          Gap(26.h),
          Header2(heading: S.current.noNotificationsYet, fontSize: 18),
          Gap(8.h),
          Title1(title: S.current.noNotificationsDesc, fontSize: 16)
        ],
      ),
    );
  }
}
