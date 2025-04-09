import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_controller.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_event.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/ui/components/text_fields/address_text_field.dart';
import 'package:cobuild/ui/components/text_fields/name_text_field.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Complete profile screen to fill :- name and location of user
class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  late AuthController controller;
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();
    _clearAllInputFields();
  }

  void _clearAllInputFields() {
    controller.clearCompleteProfileFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBar(),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: KEdgeInsets.k(h: pageHorizontalPadding),
        child: Column(
          children: [
            ShowImage(
                image: AppImages.completeProfile, height: 60.sp, width: 60.sp),
            Gap(20.h),
            Header2(heading: S.current.completeYourProfile),
            Gap(8.h),
            Title1(title: S.current.completeProfileDescription),
            Gap(fieldGap),
            NameTextField(
              controller: controller.completeProfileNameController,
              focusNode: controller.nameFocus,
              onTap: () => onTapTextfield(globalKey),
              isOnboarding: true,
            ),
            Gap(fieldGap),
            AddressTextField(
              controller: controller.completeProfileAddressController,
              focusNode: controller.addressFocus,
              onTap: () => onTapTextfield(globalKey),
              isOnboarding: true,
              locationModel: controller.completeProfileLocationModel,
            ),
            Gap(30.h),
            _continue()
          ],
        ),
      ),
    );
  }

  Widget _continue() {
    return Column(
      key: globalKey,
      children: [
        BlocBuilderNew<AuthController, AuthState>(
            onSuccess: (authState) {
              if (authState.event is CompleteProfileDataEvent) {
                _showSuccessDialog();
              }
            },
            defaultView: (authState) => AppCommonButton(
                buttonName: S.current.continueText,
                isExpanded: true,
                isLoading: (authState.event is CompleteProfileDataEvent &&
                    authState.state == BlocState.loading),
                validations: [
                  controller.completeProfileNameController,
                  controller.completeProfileAddressController
                ],
                onPressed: () {
                  controller.add(CompleteProfileDataEvent(
                      model: controller.getCompleteProfileModel()));
                })),
        Gap(majorGap)
      ],
    );
  }

  void _showSuccessDialog() {
    DialogBox().successDialog(
        subtitle: S.current.accountCreatedSuccessfully,
        onTap: () {
          context.goNamed(AppRoutes.bottomNavigation);
        });
  }
}
