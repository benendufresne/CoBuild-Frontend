import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/app_controller/app_bloc.dart';
import 'package:cobuild/bloc/controller/app_controller/app_event.dart';
import 'package:cobuild/bloc/controller/app_controller/app_state.dart';
import 'package:cobuild/bloc/controller/user_profile_bloc/user_profile_controller.dart';
import 'package:cobuild/bloc/controller/user_profile_bloc/user_profile_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/chat_icon.dart';
import 'package:cobuild/ui/components/common_text_and_icon_tile.dart';
import 'package:cobuild/ui/components/green_background_stack.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/components/text/link_text.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// To view my profile
class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late AppController appController;

  @override
  void initState() {
    super.initState();
    appController = context.read<AppController>();
    _getUserProfile();
  }

  void _getUserProfile() {
    appController.add(GetUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GreenBackgroundStack(
        child: Scaffold(
            backgroundColor: AppColors.transparent,
            appBar: CommonAppBar.appBar(
                backgroundColor: AppColors.transparent,
                title: S.current.myProfile,
                titleColor: AppColors.white,
                showBackButton: false,
                actions: [
                  Padding(
                    padding: KEdgeInsets.k(h: 12.w),
                    child: const ChatIcon(
                      iconColor: AppColors.white,
                      backgroundColor: AppColors.lightGreenColor,
                    ),
                  )
                ]),
            body: Padding(
                padding: KEdgeInsets.k(h: pageHorizontalPadding, v: 10.h),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        /// Name , Email , Address
                        _nameAndEmail(),
                        Gap(fieldGap),

                        /// Change Password
                        CommonTile(
                          icon: AppImages.changePassword,
                          label: S.current.changePassword,
                          onTap: () {
                            context.pushNamed(AppRoutes.changePassword);
                          },
                        ),

                        /// Settings
                        CommonTile(
                          icon: AppImages.setting,
                          label: S.current.setting,
                          onTap: () {
                            context.pushNamed(AppRoutes.setting);
                          },
                        ),
                        // Logout
                        CommonTile(
                          icon: AppImages.logout,
                          label: S.current.logout,
                          onTap: () {
                            DialogBox().commonDialog(
                                positiveText: S.current.confirm,
                                negativeText: S.current.cancel,
                                onTapPositive: () {
                                  context
                                      .read<AppController>()
                                      .add(LogoutEvent());
                                  context.pop();
                                },
                                title: S.current.logout,
                                subtitle: S.current.logoutConfirmation);
                          },
                        )
                      ],
                    ),
                    _loader(),
                  ],
                ))));
  }

  Widget _nameAndEmail() {
    return BlocBuilderNew<UserProfileController, UserProfileState>(
        defaultView: (blocState) {
      return Container(
        width: double.infinity,
        padding: KEdgeInsets.k20,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Header2(heading: AppPreferences.name, fontSize: 18),
                LinkText(
                    text: S.current.edit,
                    onTap: () {
                      context.pushNamed(AppRoutes.editProfile);
                    })
              ],
            ),
            Gap(8.h),
            _dataTile(AppImages.email, AppPreferences.email),
            _dataTile(AppImages.phone, AppPreferences.phone),
            _dataTile(AppImages.location, AppPreferences.address),
          ],
        ),
      );
    });
  }

  Widget _loader() {
    return BlocBuilderNew<AppController, AppState>(
        onSuccess: (blocEventState) {},
        loadingView: (blocState) {
          if (blocState.event is LogoutEvent) {
            return Center(
                child: CommonLoader(
              color: AppColors.primaryColor,
              isButtonLoader: true,
              size: 22.h,
            ));
          }
          return const SizedBox();
        },
        defaultView: (blocState) {
          return const SizedBox();
        });
  }

  Widget _dataTile(String icon, String? text) {
    if (text?.isEmpty ?? true) {
      return const SizedBox();
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 7.h),
      child: Row(
        children: [
          ShowImage(
            image: icon,
            height: 24.sp,
            width: 24.sp,
          ),
          Gap(4.w),
          Expanded(
            child: Text(text ?? '',
                style: AppStyles().regularRegular.colored(AppColors.greyText)),
          ),
        ],
      ),
    );
  }
}
