import 'package:cobuild/bloc/controller/my_profile_bloc/my_profile_controller.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/title2.dart';
import 'package:cobuild/ui/my_profile/components/profile_common_scaffold.dart';
import 'package:cobuild/ui/widgets/app_rich_text.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

/// Support page view of application
class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<StatefulWidget> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  late MyProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<MyProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCommonScaffold(
        title: S.current.support, child: _bodyOfPage());
  }

  Widget _bodyOfPage() {
    return Container(
      padding: KEdgeInsets.k20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: AppColors.white),
      child: Column(
        children: [
          const ShowImage(image: AppImages.supportDetails),
          Gap(20.h),
          Text(S.current.supportHeader,
              style: AppStyles().largeBold.colored(AppColors.blackText)),
          Gap(6.h),
          Title2(title: S.current.supportDescription),
          Gap(20.h),
          Container(
            padding: KEdgeInsets.k(h: 20.w, v: 16.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.appBackGroundColor),
            child: Row(
              children: [
                ShowImage(image: AppImages.email, height: 24.sp, width: 24.sp),
                Gap(16.w),
                AppRichText(children: [
                  AppTextSpan(
                    text: S.current.emailUs,
                    style: AppStyles().regularSemiBold,
                  ),
                  AppTextSpan(
                      text: AppConstant.supportEmail,
                      style: AppStyles()
                          .regularBolder
                          .colored(AppColors.primaryColor),
                      gesture: TapGestureRecognizerFactoryController((tap) {
                        tap.onTap = () => _mail();
                      }))
                ])
              ],
            ),
          )
        ],
      ),
    );
  }

  void _mail() {
    try {
      launchUrl(Uri(
        scheme: 'mailto',
        path: AppConstant.supportEmail,
        query: 'subject=' '&body=' '',
      ));
    } catch (error) {
      printCustom("Error on Email launching.");
    }
  }
}
