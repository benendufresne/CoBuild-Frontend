import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Common dialog box
class DialogBox {
  Future<Future<bool?>> commonDialog(
      {void Function()? onTapPositive,
      void Function()? onTapNegative,
      String? title,
      String? subtitle,
      String? positiveText,
      String? negativeText,
      bool isLoading = false,
      bool isDismissible = true}) async {
    return showDialog<bool>(
      context: ctx,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shadowColor: AppColors.transparent,
          surfaceTintColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: KBorderRadius.kAll16),
          contentPadding: EdgeInsets.all(20.sp),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title?.isNotEmpty ?? false) ...[
                Header2(heading: title ?? ''),
                Gap(8.h)
              ],
              if (subtitle != null) ...[
                _subtitle(subtitle),
              ],
              Gap(36.h),
              (positiveText == null || negativeText == null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (positiveText != null)
                          _posotiveActionButton(
                              onTap: onTapPositive, positiveText: positiveText),
                        if (negativeText != null)
                          _negativeActionButton(
                              onTap: onTapNegative, negativeText: negativeText),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: _posotiveActionButton(
                              onTap: onTapPositive, positiveText: positiveText),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: _negativeActionButton(
                              onTap: onTapNegative, negativeText: negativeText),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _subtitle(String subtitle) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: AppStyles().mediumRegular.colored(AppColors.greyText),
    );
  }

  Widget _negativeActionButton(
      {required Function()? onTap, String? negativeText}) {
    return AppCommonButton(
        buttonColor: AppColors.white,
        verticalPadding: 12,
        buttonName: negativeText ?? S.current.no,
        borderColor: AppColors.primaryColor,
        style:
            AppStyles().regularSemiBold.copyWith(color: AppColors.primaryColor),
        onPressed: () {
          if (onTap != null) {
            onTap();
          } else {
            ctx.pop();
          }
        });
  }

  Widget _posotiveActionButton(
      {required Function()? onTap, String? positiveText}) {
    return AppCommonButton(
        buttonColor: AppColors.primaryColor,
        verticalPadding: 12,
        buttonName: positiveText ?? S.current.yes,
        style: AppStyles().regularSemiBold.copyWith(color: AppColors.white),
        onPressed: () {
          if (onTap != null) {
            onTap();
          } else {
            ctx.pop();
          }
        });
  }

  Future<Future<bool?>> successDialog(
      {String? title, String? image, String? subtitle, Function? onTap}) async {
    return showDialog<bool>(
        context: ctx,
        barrierDismissible: onTap == null,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            shadowColor: AppColors.transparent,
            surfaceTintColor: AppColors.white,
            shape: RoundedRectangleBorder(borderRadius: KBorderRadius.kAll16),
            contentPadding: const EdgeInsets.all(0),
            insetPadding: KEdgeInsets.kall(a: 16.sp),
            content: Padding(
              padding: KEdgeInsets.k(h: 24.w, v: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShowImage(image: image ?? AppImages.success),
                  Gap(majorGap),
                  Header2(heading: title ?? S.current.successfully),
                  if (subtitle?.isNotEmpty ?? false)
                    Padding(
                      padding: KEdgeInsets.kOnly(t: 8.h),
                      child: _subtitle(subtitle ?? ''),
                    ),
                  Gap(majorGap),
                  AppCommonButton(
                      buttonName: S.current.okay,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      isExpanded: true,
                      onPressed: () {
                        if (onTap != null) {
                          onTap();
                        } else {
                          ctx.pop(true);
                        }
                      }),
                ],
              ),
            ),
          );
        });
  }
}
