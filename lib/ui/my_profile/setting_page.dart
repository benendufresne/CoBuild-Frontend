import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/common_text_and_icon_tile.dart';
import 'package:cobuild/ui/my_profile/components/profile_common_scaffold.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Setting page to show multiple options
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCommonScaffold(
      title: S.current.setting,
      child: Column(
        children: [
          CommonTile(
              icon: AppImages.manageNotifications,
              label: S.current.manageNotifications,
              onTap: () {
                context.pushNamed(AppRoutes.manageNotifications);
              }),
          CommonTile(
              icon: AppImages.privacyPolicy,
              label: S.current.privacyPolicy.capitalizedString,
              onTap: () {
                context.pushNamed(AppRoutes.staticContentPage,
                    extra: StaticContentEnum.privacyPolicy);
              }),
          CommonTile(
              icon: AppImages.termsAndConditions,
              label: S.current.termsAndConditions,
              onTap: () {
                context.pushNamed(AppRoutes.staticContentPage,
                    extra: StaticContentEnum.tAndC);
              }),
          CommonTile(
              icon: AppImages.aboutUs,
              label: S.current.aboutUs,
              onTap: () {
                context.pushNamed(AppRoutes.staticContentPage,
                    extra: StaticContentEnum.aboutUs);
              }),
          CommonTile(
            icon: AppImages.support,
            label: S.current.support,
            onTap: () {
              context.pushNamed(AppRoutes.support);
            },
          ),
          CommonTile(
            icon: AppImages.faq,
            label: S.current.faq,
            onTap: () {
              context.pushNamed(AppRoutes.faq);
            },
          ),
          CommonTile(
            icon: AppImages.deleteAccount,
            label: S.current.deleteAccount,
            onTap: () {
              context.pushNamed(AppRoutes.deleteAccount);
            },
          ),
        ],
      ),
    );
  }
}
