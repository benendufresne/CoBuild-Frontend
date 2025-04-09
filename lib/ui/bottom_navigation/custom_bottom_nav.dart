import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/bottom_navigation_bloc/bottom_navigation_controller.dart';
import 'package:cobuild/bloc/controller/bottom_navigation_bloc/bottom_navigation_event.dart';
import 'package:cobuild/bloc/controller/user_profile_bloc/user_profile_controller.dart';
import 'package:cobuild/bloc/controller/user_profile_bloc/user_profile_state.dart';
import 'package:cobuild/bloc/repositories/global_repo.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bottom navigation components
class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<StatefulWidget> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  late BottomNavigationController controller;
  GlobalRepository repo = GlobalRepository();
  @override
  void initState() {
    super.initState();
    controller = context.read<BottomNavigationController>();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.state.store.currentBottomNavPage,
        builder: (context, value, widget) {
          return Container(
              decoration: const BoxDecoration(color: AppColors.white),
              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 14.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomItem(
                      icon: AppImages.homeSelected,
                      unselectedIcon: AppImages.homeUnselected,
                      label: S.current.home,
                      index: 0),
                  _bottomItem(
                      icon: AppImages.estimateSelected,
                      unselectedIcon: AppImages.estimateUnselected,
                      label: S.current.reportDamage,
                      index: 1),
                  _notificationOption(),
                  _bottomItem(
                      icon: AppImages.profileSelected,
                      unselectedIcon: AppImages.profileUnselected,
                      label: S.current.myProfile,
                      index: 3),
                ],
              ));
        });
  }

  Widget _notificationOption() {
    return BlocBuilderNew<UserProfileController, UserProfileState>(
        defaultView: (blocState) {
      return _bottomItem(
          icon: repo.allNotificationsSeen
              ? AppImages.notificationSelected
              : AppImages.notificationSelectedUnSeen,
          unselectedIcon: repo.allNotificationsSeen
              ? AppImages.notificationUnselected
              : AppImages.notificationUnselectedUnSeen,
          label: S.current.notifications,
          index: 2);
    });
  }

  _bottomItem(
      {required String label,
      required String icon,
      required String unselectedIcon,
      required int index}) {
    bool isSelected =
        controller.state.store.currentBottomNavPage.value == index;
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.add(ChangeSelectedTabEvent(index: index));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Indicator icon
            if (isSelected)
              ShowImage(
                image: AppImages.indicator,
                height: 12.h,
              )
            else
              Gap(12.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ShowImage(
                image: isSelected ? icon : unselectedIcon,
                height: 32.sp,
                width: 32.sp,
              ),
            ),
            Gap(4.h),
            Text(label,
                textAlign: TextAlign.center,
                style: AppStyles().smallBold.colored(
                    isSelected ? AppColors.primaryColor : AppColors.white))
          ],
        ),
      ),
    );
  }
}
