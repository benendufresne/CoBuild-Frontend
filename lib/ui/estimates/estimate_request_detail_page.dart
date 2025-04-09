import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_details_bloc/estimate_details_controller.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_details_bloc/estimate_details_event.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_details_bloc/estimate_details_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/content_box.dart';
import 'package:cobuild/ui/components/text/title1.dart';
import 'package:cobuild/ui/components/text/title3.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_request_media_view.dart';
import 'package:cobuild/ui/estimates/common_widgets/estimate_request_status.dart';
import 'package:cobuild/ui/estimates/components/common_widgets.dart';
import 'package:cobuild/ui/shimmer_files/estimate_requests/estimate_request_details_shimmer.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/app_common_widgets.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Detail view of estimate request
class EstimateRequestDetailPage extends StatefulWidget {
  final String? id;
  const EstimateRequestDetailPage({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _EstimateRequestDetailPageState();
}

class _EstimateRequestDetailPageState extends State<EstimateRequestDetailPage> {
  late EstimateDetailsController controller;
  late EstimateDetailsStateStore store;

  @override
  void initState() {
    super.initState();
    controller = context.read<EstimateDetailsController>();
    store = controller.state.store;
    _getJobDetails();
  }

  void _getJobDetails() {
    controller.add(GetEstimateDetailsEvent(estimateId: widget.id ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar.appBar(title: S.current.requestDetail),
        bottomSheet: _chatButton(),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: KEdgeInsets.kOnly(
              t: pageVerticalPadding,
              l: pageHorizontalPadding,
              r: pageHorizontalPadding,
              b: pageVerticalPadding + 88.h),
          child:
              BlocBuilderNew<EstimateDetailsController, EstimateDetailsState>(
                  failedView: (blocState) {
            return Expanded(
              child: FailedView(onPressed: _getJobDetails),
            );
          }, noInternetView: (blocState) {
            return Expanded(child: NoInternetView(onPressed: _getJobDetails));
          }, loadingView: (blocState) {
            return const EstimateDetailsShimmer();
          }, defaultView: (blocState) {
            return _body();
          }),
        ));
  }

  Widget _chatButton() {
    return BlocBuilderNew<EstimateDetailsController, EstimateDetailsState>(
        defaultView: (blocState) {
      if (blocState.store.model == null ||
          (store.model?.chatId?.isEmpty ?? true)) {
        return const SizedBox();
      }
      return Container(
        color: AppColors.white,
        padding: KEdgeInsets.k(v: 18.h, h: 24.w),
        child: AppCommonButton(
            buttonName: S.current.chat,
            onPressed: () {
              if (store.model?.chatId?.isNotEmpty ?? false) {
                context.pushNamed(AppRoutes.chatPage,
                    extra: {AppKeys.id: store.model?.chatId});
              }
            },
            isExpanded: true),
      );
    });
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Media
        if (store.model?.media?.isNotEmpty ?? false) ...[
          EstimateRequestMediaView(
              model: MediaModel(
                  media: store.model?.media, mediaType: store.model?.mediaType),
              isDetailView: true),
          Gap(15.h)
        ],
        // Details
        _title(S.current.details),
        Gap(12.h),
        _details(),

        /// Quotation
        if ((getEstimateEnumFromBackendValue(store.model?.status ?? '') ==
                EstimatesStatusEnum.approved) &&
            isQuotationAvailable()) ...[
          Gap(16.h),
          _title(S.current.quotation),
          Gap(12.h),
          _quotation()
        ],

        /// Description
        if (store.model?.description?.isNotEmpty ?? false) ...[
          Gap(16.h),
          _title(S.current.description),
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: deviceWidth,
            padding: KEdgeInsets.k16,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.white),
            child: Text(
              store.model?.description ?? '',
              style: AppStyles().regularSemiBold,
            ),
          ),
        ]
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
    if (store.model == null) return const SizedBox();
    return ContentBox(
        child: Column(
      children: [
        // Status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.current.status),
            EstimateRequestStatus(model: store.model!)
          ],
        ),
        _divider(),
        _keyValueData(S.current.serviceCategory,
            CommonBottomSheetWidgets.serviceType(store.model!)),
        Gap(12.h),
        _keyValueData(S.current.categoryName,
            CommonBottomSheetWidgets.serviceSubType(store.model!)),
        _divider(),
        if (store.model?.name?.isNotEmpty ?? false) ...[
          _keyValueData(S.current.name, store.model?.name ?? ''),
          _divider()
        ],
        if (store.model?.location?.address?.isNotEmpty ?? false) ...[
          _keyValueData(
              S.current.address, store.model?.location?.address ?? ''),
          _divider()
        ],
        _keyValueData(S.current.requestOn, formatDate(store.model?.created)),
      ],
    ));
  }

  Widget _quotation() {
    return ContentBox(
        child: Column(
      children: [
        if (store.model?.estimatedDays?.isNotEmpty ?? false) ...[
          _keyValueData(S.current.estimatedDays,
              "${store.model?.estimatedDays} ${S.current.days}"),
          _divider()
        ],
        if (store.model?.amount != null)
          _keyValueData(
              S.current.estimatedAmount, "\$${store.model?.amount}/Day"),
      ],
    ));
  }

  bool isQuotationAvailable() {
    return ((store.model?.estimatedDays?.isNotEmpty ?? false) ||
        (store.model?.amount != null));
  }

  Widget _divider() {
    return Padding(
        padding: KEdgeInsets.k(v: 15.h), child: const AppCommonDivider());
  }

  Widget _keyValueData(String key, String value) {
    if (value.isEmpty) {
      return const SizedBox();
    }
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
