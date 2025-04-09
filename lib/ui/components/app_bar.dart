import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/widgets/common_back_button.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Commmon app bar used in complete app
class CommonAppBar {
  static AppBar appBar(
      {Color? backgroundColor,
      Color? titleColor,
      String? title,
      bool showBackButton = true,
      Widget? titleIcon,
      List<Widget>? actions}) {
    return AppBar(
        backgroundColor: backgroundColor,
        centerTitle: false,
        titleSpacing: showBackButton ? 0.w : 25.w,
        title: titleIcon != null
            ? Row(
                children: [
                  titleIcon,
                  Gap(12.w),
                  appBarTitle(title: title, titleColor: titleColor),
                ],
              )
            : appBarTitle(title: title, titleColor: titleColor),
        actions: actions,
        automaticallyImplyLeading: false,
        leading: appBarBackButton(
            showBackButton: showBackButton, titleColor: titleColor));
  }

  static Widget appBarTitle({Color? titleColor, String? title}) {
    return Text(title ?? "",
        style: AppStyles().aapBarTitle.colored(titleColor));
  }

  static Widget? appBarBackButton(
      {required bool showBackButton, Color? titleColor}) {
    return (ctx.canPop() && showBackButton)
        ? IconButton(
            onPressed: () {
              ctx.pop();
            },
            icon: AppCommonBackButton(
              color: titleColor ?? AppColors.black,
            ))
        : null;
  }

  static Widget customAppBar({
    String? title,
    Color? titleColor,
    bool showBackButton = true,
  }) {
    return Row(
      children: [
        (ctx.canPop() && showBackButton)
            ? InkWell(
                onTap: () {},
                child: AppCommonBackButton(
                  color: titleColor ?? AppColors.black,
                ))
            : const SizedBox(),
        Gap(4.w),
        appBarTitle(title: title, titleColor: titleColor),
      ],
    );
  }
}
