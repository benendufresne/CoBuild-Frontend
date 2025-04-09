import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_controller.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_event.dart';
import 'package:cobuild/models/estimates/cable_consulting_data/cable_consulting_sub_model/cable_consulting_sub_model.dart';
import 'package:cobuild/ui/components/text/title3.dart';
import 'package:cobuild/ui/estimates/components/bottom_sheet_common_widgets.dart';
import 'package:cobuild/ui/estimates/components/common_widgets.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:go_router/go_router.dart';

/// Select cable consulting sub issue
class CableConsultingSubIssueOptions extends StatefulWidget {
  const CableConsultingSubIssueOptions({super.key});

  @override
  State<StatefulWidget> createState() => _CableConsultingSubIssueOptionsState();
}

class _CableConsultingSubIssueOptionsState
    extends State<CableConsultingSubIssueOptions> {
  late EstimateRequestController controller;
  late List<CableConsultingSubCategoryModel> subIssues;
  int? _expandedTileIndex;

  @override
  void initState() {
    super.initState();
    controller = context.read<EstimateRequestController>();
    subIssues = controller.selectedCableConsultingIssueType?.issueTypeNames ??
        <CableConsultingSubCategoryModel>[];
  }

  @override
  Widget build(BuildContext context) {
    return CommonSelectableBottomSheet(
        title: controller.selectedCableConsultingIssueType?.categoryName ?? '',
        child: Column(
          children: subIssues.asMap().entries.map((entry) {
            final index = entry.key;
            final subIssue = entry.value;
            return Column(
              children: [
                _showOption(subIssue: subIssue, index: index),
                if (index != subIssues.length - 1)
                  CommonBottomSheetWidgets.commonDivider()
              ],
            );
          }).toList(),
        ));
  }

  Widget _showOption(
      {required CableConsultingSubCategoryModel subIssue, required int index}) {
    List<String> specificTypes = subIssue.subIssueNames ?? [];
    return InkWell(
      onTap: () {
        _selectOption(type: subIssue);
      },
      child: ExpansionTile(
        showTrailingIcon: specificTypes.isNotEmpty,
        enabled: specificTypes.isNotEmpty,
        initiallyExpanded: _expandedTileIndex == index,
        maintainState: true,
        onExpansionChanged: (bool expanded) {
          setState(() {
            _expandedTileIndex = expanded ? index : null;
          });
        },
        tilePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: Colors.transparent, width: 0), // Hide lines when expanded
          borderRadius: BorderRadius.circular(8),
        ),
        title: Title3(
          title: subIssue.issueTypeName,
          align: TextAlign.start,
        ),
        children: specificTypes.isNotEmpty
            ? [
                Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.r,
                      ),
                      color: AppColors.lightAquaMist,
                    ),
                    padding: KEdgeInsets.k(h: 16.w),
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, _index) {
                          String subItem = specificTypes[_index];
                          return ListTile(
                            title: Text(subItem),
                            contentPadding: EdgeInsets.zero,
                            onTap: () {
                              _selectOption(type: subIssue, name: subItem);
                            },
                          );
                        },
                        separatorBuilder: (_, _index) =>
                            CommonBottomSheetWidgets.commonDivider(),
                        itemCount: specificTypes.length)),
              ]
            : [const SizedBox()],
      ),
    );
  }

  void _selectOption(
      {required CableConsultingSubCategoryModel type, String? name}) {
    controller.add(SelectCableConsultingsubIssueInCreateRequestEvent(
        type: type, name: name));
    context.pop();
  }
}
