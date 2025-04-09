import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/change_password_bloc/change_password_controller.dart';
import 'package:cobuild/bloc/controller/change_password_bloc/change_password_event.dart';
import 'package:cobuild/bloc/controller/change_password_bloc/change_password_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/text/title3.dart';
import 'package:cobuild/ui/components/text_fields/password_field.dart';
import 'package:cobuild/ui/my_profile/components/profile_common_scaffold.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// To change password
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late ChangePasswordController controller;
  late ChangePasswordStateStore state;
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = context.read<ChangePasswordController>();
    state = controller.state.stateStore;
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCommonScaffold(
        title: S.current.changePassword,
        child: Column(
          children: [
            Title3(
              title: S.current.changePasswordDescription,
              color: AppColors.blackText,
              align: TextAlign.start,
            ),
            Gap(fieldGap),
            PasswordField(
              controller: controller.oldPasswordController,
              focusNode: controller.oldPasswordFocus,
              onTap: () => onTapTextfield(globalKey),
              showPasswordHint: false,
              label: S.current.oldPassword,
            ),
            Gap(fieldGap),
            PasswordField(
              controller: controller.newPasswordController,
              focusNode: controller.newPasswordFocus,
              onTap: () => onTapTextfield(globalKey),
              showPasswordHint: true,
              label: S.current.newPassword,
            ),
            Gap(fieldGap),
            PasswordField(
              controller: controller.confirmNewPasswordController,
              focusNode: controller.confirmNewPasswordFocus,
              onTap: () => onTapTextfield(globalKey),
              label: S.current.confirmNewPassword,
              showPasswordHint: false,
            ),
            Gap(70.h),
            _continueButton(),
          ],
        ));
  }

  Widget _continueButton() {
    return BlocBuilderNew<ChangePasswordController, ChangePasswordState>(
        onSuccess: (blocSate) {
          if (blocSate.event is ChangePasswordEvent) {
            _showSuccessDialog();
          }
        },
        defaultView: (passwordState) => Padding(
              key: globalKey,
              padding: KEdgeInsets.kOnly(b: majorGap),
              child: AppCommonButton(
                  buttonName: S.current.save,
                  isExpanded: true,
                  validations: [
                    controller.oldPasswordController,
                    controller.newPasswordController,
                    controller.confirmNewPasswordController
                  ],
                  isLoading: (passwordState.event is ChangePasswordEvent &&
                      passwordState.state == BlocState.loading),
                  onPressed: () {
                    controller
                        .add(ChangePasswordEvent(model: controller.getModel()));
                  }),
            ));
  }

  void _showSuccessDialog() {
    DialogBox().successDialog(
        title: S.current.congratulation,
        subtitle: S.current.passwordChangedSuccessfully,
        onTap: () {
          context.pop();
          context.pop();
        });
  }
}
