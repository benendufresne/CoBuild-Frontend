import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_controller.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_event.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/jobs/job_card.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/link_text.dart';
import 'package:cobuild/ui/home_page/job_search_and_filter_widget.dart';
import 'package:cobuild/ui/home_page/dynamic_map/job_map.dart';
import 'package:cobuild/ui/widgets/app_rich_text.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Dynmaic Map view main page
class DynamicMapView extends StatefulWidget {
  final JobModel? model;
  const DynamicMapView({super.key, this.model});

  @override
  State<StatefulWidget> createState() => _DynamicMapViewState();
}

class _DynamicMapViewState extends State<DynamicMapView> {
  double bottomSheetHeight = 95.h;
  late DynamicMapController controller;
  @override
  void initState() {
    super.initState();
    controller = context.read<DynamicMapController>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilderNew<DynamicMapController, DynamicMapState>(
        defaultView: (blocState) {
      return Scaffold(
          bottomSheet: _totalJobsCount(),
          appBar: CommonAppBar.appBar(title: S.current.dynamicMapView),
          body: Stack(
            children: [
              Padding(
                  padding: KEdgeInsets.kOnly(b: bottomSheetHeight),
                  child: LocationMapView(jobModel: widget.model)),
              if (widget.model == null) _searchAndFilter(),
              _selectedJobCard(blocState),
            ],
          ));
    });
  }

  Widget _searchAndFilter() {
    return Padding(
        padding: KEdgeInsets.k20,
        child: const JobSearchAndFilterWidget(isHomePage: false));
  }

  Widget _totalJobsCount() {
    int count = widget.model != null ? 1 : controller.totalJobCount;
    if (count == 0) {
      return const SizedBox();
    }
    return Container(
      padding: KEdgeInsets.kOnly(t: 12.h, l: 25.w, r: 25.w, b: 35.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
          color: AppColors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Divider
          Container(
            height: 4.h,
            width: 80.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: AppColors.disabledButtonColor),
          ),
          Gap(20.h),
          // Jobs Count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppRichText(children: [
                AppTextSpan(
                    text: "$count ", style: AppStyles().sLargeSemiBlock),
                AppTextSpan(
                    text: count > 1 ? S.current.jobsFound : S.current.jobFound,
                    style: AppStyles().largeBolder)
              ]),
              if (count > 1)
                LinkText(
                    text: S.current.viewAll,
                    onTap: () {
                      context.pushNamed(AppRoutes.nearByJobs);
                    })
            ],
          )
        ],
      ),
    );
  }

  Widget _selectedJobCard(blocState) {
    if (blocState.store.selectedJobModel == null) {
      return const SizedBox();
    } else {
      return Positioned(
          bottom: bottomSheetHeight,
          right: 0,
          left: 0,
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black.withOpacity(0.25)),
                  borderRadius: BorderRadius.circular(8.r)),
              margin: KEdgeInsets.k8,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  JobCard(model: blocState.store.selectedJobModel!),
                  Positioned(
                      top: -16.h,
                      left: (deviceWidth - 48.h) / 2,
                      child: InkWell(
                        onTap: () {
                          controller.add(const CloseSeleectedJobOnMapEvent());
                        },
                        child: Container(
                            height: 32.h,
                            width: 32.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: AppColors.primaryColor,
                            ),
                            child: ShowImage(
                                image: AppImages.closeIcon,
                                color: AppColors.white,
                                height: 14.h,
                                width: 14.h)),
                      )),
                ],
              )));
    }
  }
}
