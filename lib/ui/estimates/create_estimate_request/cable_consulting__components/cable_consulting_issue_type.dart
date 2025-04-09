import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_controller.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_controller.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_event.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/estimates/cable_consulting_data/cable_consulting_model/cable_consulting_model.dart';
import 'package:cobuild/models/estimates/cable_consulting_data/top_level_cable_consulting_model/top_level_cable_consulting_model.dart';
import 'package:cobuild/ui/estimates/components/bottom_sheet_common_widgets.dart';
import 'package:cobuild/ui/estimates/components/common_widgets.dart';
import 'package:cobuild/ui/home_page/jobs/job_listing/empty_job_listing.dart';
import 'package:cobuild/ui/shimmer_files/service_category_listing_shimmer.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Select cable consulting issue type
class CableConsultingIssueType extends StatefulWidget {
  final Function(TopLevelCableConsultingIssueModel type) onSelect;
  const CableConsultingIssueType({super.key, required this.onSelect});

  @override
  State<StatefulWidget> createState() => _CableConsultingIssueTypeSate();
}

class _CableConsultingIssueTypeSate extends State<CableConsultingIssueType> {
  late EstimateRequestController controller;
  late ServiceCategoryStateStore serviceCategoryStateStore;
  late ServiceCategoryController serviceCategoryController;

  @override
  void initState() {
    super.initState();
    controller = context.read<EstimateRequestController>();
    serviceCategoryController = context.read<ServiceCategoryController>();
    serviceCategoryStateStore = serviceCategoryController.state.store;
    _getData();
  }

  void _getData() {
    if ((serviceCategoryController.state.event
        is! GetCableConsultingDataEvent)) {
      serviceCategoryController.add(const GetCableConsultingDataEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonSelectableBottomSheet(
        title: S.current.selectIssue,
        child: SizedBox(
          height: deviceHeight * 0.6,
          child:
              BlocBuilderNew<ServiceCategoryController, ServiceCategoryState>(
                  failedView: (blocState) {
            if (blocState.event is GetCableConsultingDataEvent) {
              return FailedView(onPressed: () {
                _getData();
              });
            }
            return _showData();
          }, noInternetView: (blocState) {
            return NoInternetView(onPressed: () {
              _getData();
            });
          }, loadingView: (blocState) {
            if ((blocState.event is GetCableConsultingDataEvent) &&
                isNullData) {
              return const CategoryServiceShimmer(itemCount: 3);
            }
            return _showData();
          }, defaultView: (blocState) {
            if (isNullData) {
              return EmptyListing(title: S.current.noDataFound);
            }
            return _showData();
          }),
        ));
  }

  bool get isNullData => serviceCategoryStateStore.cableConsultingModel == null;

  Widget _showData() {
    CableConsultingModel? cableConsultingModelList =
        serviceCategoryStateStore.cableConsultingModel;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cableConsultingModelList?.data.length ?? 0,
      itemBuilder: (context, index) {
        TopLevelCableConsultingIssueModel? model =
            cableConsultingModelList?.data[index];
        return InkWell(
            onTap: () {
              if (model != null) {
                widget.onSelect(model);
                context.pop();
              }
            },
            child: CommonBottomSheetWidgets.option(model?.categoryName ?? ''));
      },
      separatorBuilder: (context, index) {
        return CommonBottomSheetWidgets.commonDivider();
      },
    );
  }
}
