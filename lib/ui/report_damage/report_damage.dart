import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/report_damage/add_damage_report/add_damage_report_controller.dart';
import 'package:cobuild/bloc/controller/report_damage/add_damage_report/add_damage_report_event.dart';
import 'package:cobuild/bloc/controller/report_damage/add_damage_report/add_damage_report_state.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_data/damage_report_controller.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/text_fields/address_text_field.dart';
import 'package:cobuild/ui/components/text_fields/description_text_field.dart';
import 'package:cobuild/ui/components/text_fields/name_text_field.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/ui/widgets/media/select_multiple_media.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cobuild/utils/app_keys.dart';

/// Report a new damage
class DamageReportForm extends StatefulWidget {
  final DamageModel? model;
  const DamageReportForm({super.key, this.model});

  @override
  State<StatefulWidget> createState() => _DamageReportFormState();
}

class _DamageReportFormState extends State<DamageReportForm> {
  late AddDamageController controller;
  late DamageReportListingController damageListingController;

  @override
  void initState() {
    super.initState();
    controller = context.read<AddDamageController>();
    damageListingController = context.read<DamageReportListingController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar.appBar(title: S.current.reportDamage),
        bottomSheet: _createButton(),
        body: SingleChildScrollView(
            padding: KEdgeInsets.kOnly(
                t: pageVerticalPadding,
                l: pageHorizontalPadding,
                r: pageHorizontalPadding,
                b: pageVerticalPadding + 88.h),
            child: _bodyOfPage()));
  }

  Widget _bodyOfPage() {
    return BlocBuilderNew<AddDamageController, AddDamageState>(
        defaultView: (blocState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type of Damage
          NameTextField(
            controller: controller.typeOfDamageController,
            focusNode: controller.typeOfDamageFocus,
            hint: S.current.typeOfDamage,
            maxLength: AppConstant.typeOfDamageMaxLength,
          ),
          Gap(fieldGap),
          // Damage Description
          DescriptionTextField(
              controller: controller.descriptionController,
              focusNode: controller.descriptionFocus,
              hint: S.current.addDamageDescription,
              maxLength: AppConstant.reportDamageDescriptionMaxLength),
          Gap(fieldGap / 2),
          // Location
          AddressTextField(
              controller: controller.addressController,
              focusNode: controller.addressFocus,
              hintText: S.current.addLocation,
              locationModel: controller.locationModel),

          Gap(fieldGap),

          // Media
          AddMultipleMediaWidget(onSelect: (files) {
            controller.add(AddMediaInDamageReportEvent(files: files));
          }),
        ],
      );
    });
  }

  Widget _createButton() {
    double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    if (keyboardSpace > 0) return const SizedBox();
    return BlocBuilderNew<AddDamageController, AddDamageState>(
        onSuccess: (blocState) {
      if (blocState.event is AddDamageReportEvent) {
        if ((blocState.response?.data != null) &&
            (blocState.response?.data is DamageModel)) {
          DamageModel model = blocState.response?.data as DamageModel;
          _showSuccessDialog(chatId: model.chatId);
        } else {
          _showSuccessDialog();
        }
      }
    }, defaultView: (blocState) {
      return Container(
        color: AppColors.white,
        padding: KEdgeInsets.k(v: 18.h, h: 24.w),
        child: AppCommonButton(
            buttonName: S.current.create,
            isLoading: (blocState.state == BlocState.loading &&
                blocState.event is AddDamageReportEvent),
            onPressed: () {
              if (controller.isAllDetailsFilled) {
                controller.add(
                    AddDamageReportEvent(model: controller.getCreateModel));
              } else {
                showSnackBar(message: S.current.provideRequiredDetails);
              }
            },
            isExpanded: true),
      );
    });
  }

  void _showSuccessDialog({String? chatId}) {
    DialogBox().successDialog(
        subtitle: S.current.damageReportedSuccessfully,
        onTap: () {
          context.pop();
          context.pop();
          if (chatId != null) {
            context.pushNamed(AppRoutes.chatPage, extra: {AppKeys.id: chatId});
          }
        });
  }
}
