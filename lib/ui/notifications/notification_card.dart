import 'package:cobuild/bloc/controller/notification_bloc/notification_controller.dart';
import 'package:cobuild/bloc/controller/notification_bloc/notification_event.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/notifications/notification_model.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/notifications/notification_indicator_dot.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Notification card
class NotificationCard extends StatelessWidget {
  final NotificationModel model;
  const NotificationCard({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
        key: Key(model.sId ?? ''),
        trailingActions: [
          SwipeAction(
              color: AppColors.transparent,
              widthSpace: 90.w,
              content: InkWell(
                onTap: () {
                  _showDeleteOption();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.errorTextFieldColor,
                  ),
                  margin: KEdgeInsets.kOnly(l: 10),
                  padding: KEdgeInsets.k(h: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ShowImage(
                          image: AppImages.deleteIcon, color: AppColors.white),
                      Gap(5.h),
                      Text(S.current.delete,
                          style: AppStyles()
                              .regularSemiBold
                              .colored(AppColors.white))
                    ],
                  ),
                ),
              ),
              nestedAction: SwipeNestedAction(title: S.current.confirm),
              onTap: (handler) async {})
        ],
        child: InkWell(
          onTap: () {
            _markNotificationRead();
            navigateNotificationToDetailsPage(model);
          },
          child: Container(
            padding: KEdgeInsets.k(h: 10.w, v: 16.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                _bellIcon(),
                Gap(6.w),
                // Data
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        model.title ?? '',
                        maxLines: 2,
                        style: AppStyles()
                            .regularBold
                            .colored(AppColors.blackText),
                      ),
                      Gap(2.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Description
                          if (model.message?.isNotEmpty ?? false) ...[
                            Expanded(
                              child: Text(
                                model.message ?? '',
                                maxLines: 3,
                                style: AppStyles()
                                    .smallSemiBold
                                    .colored(AppColors.lightGreyText),
                              ),
                            ),
                            Gap(10.w)
                          ],
                          // Time
                          _time()
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _bellIcon() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: AppColors.appBackGroundColor,
          ),
          child: const ShowImage(image: AppImages.notificationIconGreen),
        ),
        if (!model.isRead)
          const Positioned(top: 6, right: 8, child: NotificationIndicatorDot())
      ],
    );
  }

  Widget _time() {
    return Text(
      timeAgo(model.created),
      style: AppStyles().smallSemiBold.colored(AppColors.black),
    );
  }

  void _markNotificationRead() {
    ctx
        .read<NotificationsController>()
        .add(ReadNotificationEvent(model: model));
  }

  void _showDeleteOption() {
    DialogBox().commonDialog(
      title: S.current.deleteNotification,
      subtitle: S.current.deleteNotificationDetails,
      positiveText: S.current.confirm,
      onTapPositive: deleteNotification,
      negativeText: S.current.cancel,
    );
  }

  void deleteNotification() {
    ctx.pop();
    ctx
        .read<NotificationsController>()
        .add(DeleteNotificationEvent(model: model));
  }
}
