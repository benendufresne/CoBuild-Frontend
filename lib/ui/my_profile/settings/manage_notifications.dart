import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/my_profile_bloc/my_profile_controller.dart';
import 'package:cobuild/bloc/controller/my_profile_bloc/my_profile_event.dart';
import 'package:cobuild/bloc/controller/my_profile_bloc/my_profile_state.dart';
import 'package:cobuild/models/user_model/user_model.dart';
import 'package:cobuild/ui/my_profile/components/profile_common_scaffold.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/ui/widgets/switch_widget.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Manage notification page to enable or disable notifications
class ManageNotificationsPage extends StatefulWidget {
  const ManageNotificationsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ManageNotificationsPageState();
}

class _ManageNotificationsPageState extends State<ManageNotificationsPage> {
  late MyProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<MyProfileController>();
    controller.setInitialNotificationOreference();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCommonScaffold(
        title: S.current.manageNotifications, child: _bodyOfPage());
  }

  Widget _bodyOfPage() {
    return BlocBuilderNew<MyProfileController, MyProfileState>(
        defaultView: (blocState) => Column(
              children: [
                Container(
                  padding: KEdgeInsets.kOnly(r: 8.w, l: 16.w, t: 8.h, b: 16.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.current.notifications,
                              style: AppStyles()
                                  .regularSemiBold
                                  .colored(AppColors.black)),
                          Gap(12.w),
                          _toogle(),
                        ],
                      ),
                      Gap(2.h),
                      Text(S.current.toogleOnOffNotifications,
                          style: AppStyles()
                              .regularRegular
                              .colored(AppColors.greyText)),
                    ],
                  ),
                ),
                if (isupdatingState) const CommonLoader()
              ],
            ));
  }

  bool get isupdatingState =>
      (controller.state.event is UpdateNotificationPreferenceEvent &&
          controller.state.state == BlocState.loading);

  Widget _toogle() {
    return ValueListenableBuilder(
      valueListenable: controller.state.store.notificationPermission,
      builder: (context, value, widget) {
        return SwitchWidget(
            value: value,
            onChanged: () {
              if (isupdatingState) return;
              controller.state.store.notificationPermission.value = !value;
              controller.add(UpdateNotificationPreferenceEvent(
                  model: UserModel(notification: !value)));
            });
      },
    );
  }
}
