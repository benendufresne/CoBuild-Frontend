import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_controller.dart';
import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Common chat icon used in app
class ChatIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final bool isHomePage;
  const ChatIcon(
      {super.key,
      this.backgroundColor = AppColors.backgroundGrey,
      this.iconColor = AppColors.primaryColor,
      this.isHomePage = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilderNew<ChatInboxController, ChatInboxListState>(
        defaultView: (blocState) => InkWell(
            onTap: () {
              context.pushNamed(AppRoutes.chatInboxPage);
            },
            child: Stack(
              children: [
                _icon(),
                _unreadDot(),
              ],
            )));
  }

  Widget _icon() {
    if (isHomePage) {
      return ShowImage(
          image: AppImages.chatIconGreen, height: 48.h, width: 48.h);
    }
    return Container(
        padding: EdgeInsets.all(9.h),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(6.r)),
        child: ShowImage(
            image: AppImages.chatIcon,
            height: 18.h,
            width: 18.h,
            color: iconColor));
  }

  Widget _unreadDot() {
    if (!ctx.read<ChatInboxController>().state.stateStore.isUnRead) {
      return const SizedBox();
    }
    double height = isHomePage ? 10.h : 7.h;
    double position = isHomePage ? 12.h : 9.h;
    return Positioned(
        top: position,
        right: position,
        child: Container(
          height: height,
          width: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height / 2),
              color: AppColors.rejectedStatusColor),
        ));
  }
}
