import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/delete_account_bloc/delete_account_controller.dart';
import 'package:cobuild/bloc/controller/delete_account_bloc/delete_account_event.dart';
import 'package:cobuild/bloc/controller/delete_account_bloc/delete_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/text_fields/password_field.dart';
import 'package:cobuild/ui/my_profile/components/profile_common_scaffold.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// For acccount deletion
class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<StatefulWidget> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  late DeleteAccountController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<DeleteAccountController>();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCommonScaffold(
        title: S.current.deleteAccount,
        child: Column(
          children: [
            Text(S.current.deleteAccountDescription,
                style: AppStyles().mediumSemibold.colored(AppColors.blackText)),
            Gap(fieldGap),
            PasswordField(
                controller: controller.deleteAccountPasswordController,
                focusNode: controller.deleteAccountPasswordFocus),
            Gap(100.h),
            BlocBuilderNew<DeleteAccountController, DeleteAccountState>(
                onSuccess: (blocState) {
                  if (blocState.event is DeleteAccountEvent) {
                    _showSuccessDialog();
                  }
                },
                defaultView: (blocState) => AppCommonButton(
                    buttonName: S.current.confirm,
                    isExpanded: true,
                    isLoading: (blocState.state == BlocState.loading &&
                        blocState.event is DeleteAccountEvent),
                    validations: [controller.deleteAccountPasswordController],
                    onPressed: () {
                      _deleteAccount();
                    }))
          ],
        ));
  }

  void _showSuccessDialog() {
    DialogBox().successDialog(
        title: S.current.accountDeleted,
        image: AppImages.greenCheck,
        subtitle: S.current.accountDeletedDescription,
        onTap: () {
          context.pop();
          context.goNamed(AppRoutes.login);
        });
  }

  void _deleteAccount() {
    controller.add(DeleteAccountEvent(
        password: controller.deleteAccountPasswordController.text.trim()));
  }
}
