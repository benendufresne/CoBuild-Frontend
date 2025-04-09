import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/edit_profile_bloc/edit_profile_controller.dart';
import 'package:cobuild/bloc/controller/edit_profile_bloc/edit_profile_event.dart';
import 'package:cobuild/bloc/controller/edit_profile_bloc/edit_profile_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/text_fields/address_text_field.dart';
import 'package:cobuild/ui/components/text_fields/email_text_field.dart';
import 'package:cobuild/ui/components/text_fields/name_text_field.dart';
import 'package:cobuild/ui/components/text_fields/phone_text_field.dart';
import 'package:cobuild/ui/my_profile/components/profile_common_scaffold.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// To Edit profile of user
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late EditProfileController controller;
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = context.read<EditProfileController>();
    controller.initData();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCommonScaffold(
        title: S.current.editProfile,
        child: Column(
          children: [
            NameTextField(
              controller: controller.nameController,
              focusNode: controller.nameFocus,
              onTap: () => onTapTextfield(globalKey),
            ),
            Gap(fieldGap),
            PhoneTextField(
              controller: controller.phoneController,
              focusNode: controller.phoneFocus,
              countryCodeController: controller.countrycode,
              onTap: () => onTapTextfield(globalKey),
            ),
            Gap(fieldGap),
            EmailTextField(
              controller: controller.emailController,
              focusNode: controller.emailFocus,
              isEnable: controller.enableEmailField,
              onTap: () => onTapTextfield(globalKey),
              isRequired: false,
            ),
            Gap(fieldGap),
            AddressTextField(
              controller: controller.addressController,
              focusNode: controller.addressFocus,
              onTap: () => onTapTextfield(globalKey),
              locationModel: controller.addressModel,
            ),
            Gap(36.h),
            _continueButton(),
          ],
        ));
  }

  Widget _continueButton() {
    return BlocBuilderNew<EditProfileController, EditProfileState>(
        onSuccess: (blocSate) {
          if (blocSate.event is EditProfileEvent) {
            _showSuccessDialog();
          }
        },
        defaultView: (blocState) => Padding(
              key: globalKey,
              padding: KEdgeInsets.kOnly(b: majorGap * 1.5),
              child: AppCommonButton(
                  buttonName: S.current.update,
                  isExpanded: true,
                  validations: [
                    controller.nameController,
                    controller.emailController,
                    controller.phoneController,
                    controller.addressController
                  ],
                  isLoading: (blocState.event is EditProfileEvent &&
                      blocState.state == BlocState.loading),
                  onPressed: () {
                    controller
                        .add(EditProfileEvent(model: controller.getModel()));
                  }),
            ));
  }

  void _showSuccessDialog() {
    DialogBox().successDialog(
        subtitle: S.current.profileUpdatedSuccessfully,
        onTap: () {
          context.pop();
          context.pop();
        });
  }
}
