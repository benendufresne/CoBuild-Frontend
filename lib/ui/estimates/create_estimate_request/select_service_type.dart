import 'package:cobuild/ui/estimates/components/bottom_sheet_common_widgets.dart';
import 'package:cobuild/ui/estimates/components/common_widgets.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Select category option
class SelectCategory extends StatelessWidget {
  final Function(ServiceTypeEnum type) onselect;
  const SelectCategory({super.key, required this.onselect});

  @override
  Widget build(BuildContext context) {
    return CommonSelectableBottomSheet(
      title: S.current.selectService,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ServiceTypeEnum.values.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                onselect(ServiceTypeEnum.values[index]);
                context.pop();
              },
              child: CommonBottomSheetWidgets.option(
                  ServiceTypeEnum.values[index].enumValue.displayName));
        },
        separatorBuilder: (context, index) {
          return CommonBottomSheetWidgets.commonDivider();
        },
      ),
    );
  }
}
