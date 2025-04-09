import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_details_bloc/damage_report_details_controller.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_details_bloc/damage_report_details_event.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_details_bloc/damage_report_details_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/content_box.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/ui/components/text/title3.dart';
import 'package:cobuild/ui/report_damage/damage_status.dart';
import 'package:cobuild/ui/report_damage/show_multiple_images.dart';
import 'package:cobuild/ui/shimmer_files/estimate_requests/estimate_request_details_shimmer.dart';
import 'package:cobuild/ui/widgets/app_common_widgets.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Report damage main page view :- list along with new report option
class ReportDamageDetailPage extends StatefulWidget {
  final String id;
  const ReportDamageDetailPage({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _ReportDamageDetailPageState();
}

class _ReportDamageDetailPageState extends State<ReportDamageDetailPage> {
  late DamageReportDetailsController controller;
  late DamageReportDetailsStateStore store;

  @override
  void initState() {
    super.initState();
    controller = context.read<DamageReportDetailsController>();
    store = controller.state.store;
    _getReportDetails();
  }

  void _getReportDetails() {
    controller.add(GetDamageReportDetailsEvent(damageReportId: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar.appBar(title: S.current.reportDetail),
        body: SingleChildScrollView(
          padding: KEdgeInsets.kOnly(
              t: pageVerticalPadding,
              l: pageHorizontalPadding,
              r: pageHorizontalPadding,
              b: pageVerticalPadding),
          child: BlocBuilderNew<DamageReportDetailsController,
              DamageReportDetailsState>(failedView: (blocState) {
            return Expanded(
              child: FailedView(onPressed: _getReportDetails),
            );
          }, noInternetView: (blocState) {
            return Expanded(
                child: NoInternetView(onPressed: _getReportDetails));
          }, loadingView: (blocState) {
            return const EstimateDetailsShimmer();
          }, defaultView: (blocState) {
            return _bodyOfPage();
          }),
        ));
  }

  Widget _bodyOfPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Media
        if (store.model?.media?.isNotEmpty ?? false) ...[
          MediaCarousel(mediaList: store.model?.media ?? []),
          Gap(15.h)
        ],
        // Details
        _title(S.current.details),
        Gap(12.h),
        _details(),
        Gap(16.h),
        // Description
        _title(S.current.description),
        Container(
          margin: EdgeInsets.only(top: 12.h),
          width: deviceWidth,
          padding: KEdgeInsets.k16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r), color: AppColors.white),
          child: Text(
            store.model?.description ?? '',
            style: AppStyles().regularSemiBold,
          ),
        ),
      ],
    );
  }

  Widget _title(String text) {
    return Text(
      text,
      style: AppStyles().mediumBold.colored(AppColors.black),
    );
  }

  Widget _details() {
    return ContentBox(
        child: Column(
      children: [
        // Status
        if (store.model != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.current.status),
              DamageReportStatus(model: store.model!)
            ],
          ),
        _divider(),
        _keyValueData(S.current.typeOfDamage, store.model?.type ?? ''),
        _divider(),
        _keyValueData(S.current.location, store.model?.location?.address ?? ''),
        if (store.model?.created != null) ...[
          _divider(),
          _keyValueData(S.current.reportedOn, formatDate(store.model?.created))
        ],
      ],
    ));
  }

  Widget _divider() {
    return Padding(
        padding: KEdgeInsets.k(v: 15.h), child: const AppCommonDivider());
  }

  Widget _keyValueData(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Title1(title: key, color: AppColors.blackText),
        Gap(15.w),
        Flexible(
            child: Title3(
          title: value,
          color: AppColors.blackText,
          align: TextAlign.end,
        )),
      ],
    );
  }
}
