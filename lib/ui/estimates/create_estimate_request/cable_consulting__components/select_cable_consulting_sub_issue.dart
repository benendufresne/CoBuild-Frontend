import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_controller.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_state.dart';
import 'package:cobuild/ui/components/text_fields/drop_down_text_field.dart';
import 'package:cobuild/ui/estimates/create_estimate_request/cable_consulting__components/cable_consulting_sub_issue_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cable consulting sub issue view
class CableConsultingSubIssueTextField extends StatefulWidget {
  const CableConsultingSubIssueTextField({super.key});
  @override
  State<StatefulWidget> createState() =>
      _CableConsultingSubIssueTextFieldState();
}

class _CableConsultingSubIssueTextFieldState
    extends State<CableConsultingSubIssueTextField> {
  late EstimateRequestController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<EstimateRequestController>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilderNew<EstimateRequestController, EstimateRequestState>(
        defaultView: (blocState) {
      return DropDownTextField(
        controller: controller.consultingSubIssueController,
        focusNode: controller.consultingSubIssueFocus,
        hintText:
            controller.selectedCableConsultingIssueType?.categoryName ?? '',
        onTap: () {
          if (controller.selectedCableConsultingIssueType != null) {
            return showIssueSelectionSheet();
          }
        },
      );
    });
  }

  void showIssueSelectionSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const CableConsultingSubIssueOptions();
        });
  }
}
