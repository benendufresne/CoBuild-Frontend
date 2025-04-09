import 'package:cached_network_image/cached_network_image.dart';
import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/job/job_details/job_details_controller.dart';
import 'package:cobuild/bloc/controller/job/job_details/job_details_event.dart';
import 'package:cobuild/bloc/controller/job/job_details/job_details_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/library/shimmer/shimmer.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/jobs/job_card_title_image.dart';
import 'package:cobuild/ui/components/jobs/job_common_components.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/link_text.dart';
import 'package:cobuild/ui/shimmer_files/jobs/job_details_shimmer.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/app_common_widgets.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Show details of a job
class JobDetailsPage extends StatefulWidget {
  final String? id;
  const JobDetailsPage({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  late JobDetailsController controller;
  late JobDetailsStateStore store;

  @override
  void initState() {
    super.initState();
    controller = context.read<JobDetailsController>();
    store = controller.state.store;
    _getJobDetails();
  }

  void _getJobDetails() {
    controller.add(GetJobDetailsEvent(jobId: widget.id ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            _header(),
            BlocBuilderNew<JobDetailsController, JobDetailsState>(
                failedView: (blocState) {
              if (blocState.event is GetJobDetailsEvent) {
                return Expanded(
                  child: FailedView(onPressed: () {
                    _getJobDetails();
                  }),
                );
              } else {
                return _defaultView();
              }
            }, noInternetView: (blocState) {
              if (blocState.event is GetJobDetailsEvent) {
                return Expanded(child: NoInternetView(onPressed: () {
                  _getJobDetails();
                }));
              } else {
                return _defaultView();
              }
            }, defaultView: (blocState) {
              return _defaultView();
            })
          ],
        ));
  }

  Widget _defaultView() {
    return Expanded(
        child: Stack(
      children: [
        Container(
          height: 30.h,
          width: deviceWidth,
          color: AppColors.primaryColor,
        ),
        SingleChildScrollView(
            physics: const ClampingScrollPhysics(), child: _pageData())
      ],
    ));
  }

  Widget _header() {
    return Container(
      padding: KEdgeInsets.kOnly(b: 12.h, l: 3.h, r: 20.h, t: 10.h),
      decoration: const BoxDecoration(color: AppColors.primaryColor),
      child: SafeArea(
        bottom: false,
        child: CommonAppBar.customAppBar(
            title: S.current.jobDetail, titleColor: AppColors.white),
      ),
    );
  }

  Widget _pageData() {
    return Container(
      padding: KEdgeInsets.k(h: pageHorizontalPadding, v: pageVerticalPadding),
      width: deviceWidth,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          )),
      child: _body(),
    );
  }

  Widget _body() {
    if (controller.state.event is GetJobDetailsEvent &&
        controller.state.state == BlocState.loading) {
      return const JobDetailsShimmer();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        _jobTitle(),
        Gap(14.h),
        // Category
        _category(),
        Gap(12.h),
        // Timing and Location
        _timeAndLocation(),
        Gap(16.h),
        // Details Tab View
        _details()
      ],
    );
  }

  Widget _jobTitle() {
    return Row(
      children: [
        const JobCardTitleImage(),
        Gap(12.w),
        Text(store.model?.title ?? '', style: AppStyles().mediumBolder)
      ],
    );
  }

  Widget _category() {
    return Text(
      store.model?.categoryName ?? '',
      style: AppStyles().largeBolder,
    );
  }

  Widget _timeAndLocation() {
    TextStyle style = AppStyles().smallRegular.colored(AppColors.greyText);
    return Row(
      children: [
        ShowImage(
          height: 20.h,
          image: AppImages.clock,
        ),
        Padding(
            padding: KEdgeInsets.kOnly(l: 8),
            child: Text(JobCommonComponents.jobPostTime(store.model),
                style: style)),
        Gap(15.w),
        ShowImage(
          image: AppImages.locationIconGreen,
          height: 20.h,
        ),
        Expanded(
          child: Padding(
            padding: KEdgeInsets.kOnly(l: 8),
            child: Text(store.model?.location?.address ?? '', style: style),
          ),
        ),
      ],
    );
  }

  Widget _details() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Job Procedure
      if (store.model?.procedure?.isNotEmpty ?? false) ...[
        _titleText(S.current.jobProcedure),
        _descriptionText(store.model?.procedure ?? ''),
        Gap(16.h),
      ],
      // Contact info
      _subTitleText(S.current.contactInformationOfManager),
      _contactInfo(),
      Gap(16.h),
      if (store.model?.serviceType?.isNotEmpty ?? false) ...[
        _subTitleText(S.current.serviceCategory),
        _serviceType(),
        Gap(16.h)
      ],
      if (store.model?.schedule != null) ...[
        _subTitleText(S.current.schedule),
        _schedule(),
        Gap(16.h)
      ],
      _subTitleText(S.current.doorTag),
      _doorTag(),
      // About Company
      Padding(padding: KEdgeInsets.k(v: 20.h), child: const AppCommonDivider()),
      if (store.model?.aboutCompany?.isNotEmpty ?? false) ...[
        _titleText(S.current.aboutCompany),
        _descriptionText(store.model?.aboutCompany ?? ''),
        // Address
        Padding(
            padding: KEdgeInsets.k(v: 20.h), child: const AppCommonDivider())
      ],
      if (store.model?.companyLocation?.address?.isNotEmpty ?? false) ...[
        _titleText(S.current.compnayAddress),
        Row(
          children: [
            ShowImage(
                image: AppImages.locationIconGreen, height: 24.h, width: 24.h),
            Gap(8.w),
            Expanded(
              child: Text(store.model?.companyLocation?.address ?? '',
                  maxLines: 3,
                  style: AppStyles()
                      .regularSemiBold
                      .copyWith(color: AppColors.lightGreyText)),
            ),
          ],
        ),
        Padding(
            padding: KEdgeInsets.k(v: 20.h), child: const AppCommonDivider())
      ],
      // Dynamic Map
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _titleText(S.current.dynamicMapView),
          LinkText(
              text: S.current.clickToView,
              isUnderLine: true,
              onTap: () {
                ctx.pushNamed(AppRoutes.dynamicMap,
                    extra: {AppKeys.model: store.model});
              })
        ],
      ),

      /// Chat With Us
      Gap(majorGapVertical),
      if (JobCommonComponents().isValidForChat(store.model?.status))
        AppCommonButton(
            buttonName: S.current.chatWithUs,
            isLoading: ((controller.state.event is GetJobChatIdEvent) &&
                (controller.state.state == BlocState.loading)),
            onPressed: () {
              _navigateToChatPage();
            },
            isExpanded: true)
    ]);
  }

  Widget _titleText(String title) {
    return Padding(
      padding: KEdgeInsets.kOnly(b: 10.h),
      child: Text(title, style: AppStyles().mediumBolder),
    );
  }

  Widget _subTitleText(String title) {
    return Padding(
      padding: KEdgeInsets.kOnly(b: 8.h),
      child: Text(title, style: AppStyles().regularBolder),
    );
  }

  Widget _descriptionText(String description) {
    return Text(description,
        style: AppStyles()
            .regularSemiBold
            .copyWith(color: AppColors.lightGreyText));
  }

  Widget _doorTag() {
    return Container(
      height: 100.h,
      width: 100.h,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.black.withOpacity(0.1))),
      child: CachedNetworkImage(
        imageUrl: store.model?.doorTag ?? '',
        placeholder: (context, value) {
          return shimmerCard(height: 80.h, width: 80.h);
        },
        errorWidget: (context, value, error) =>
            shimmerCard(height: 80.h, width: 80.h),
      ),
    );
  }

  Widget _contactInfo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            contactDetailData(
                AppImages.person, store.model?.personalName ?? ''),
            Gap(20.w),
            contactDetailData(AppImages.email, store.model?.email ?? ''),
          ],
        ),
        Gap(12.h),
        contactDetailData(AppImages.phone, store.model?.fullMobileNo ?? ''),
      ],
    );
  }

  Widget contactDetailData(String image, String data) {
    if (data.isEmpty) {
      return const SizedBox();
    }
    return Row(
      children: [
        ShowImage(image: image, height: 24.h, width: 24.h),
        Gap(8.w),
        Text(data,
            style: AppStyles()
                .regularSemiBold
                .copyWith(color: AppColors.lightGreyText)),
      ],
    );
  }

  Widget _serviceType() {
    return contactDetailData(
        AppImages.serviceCategory, store.model?.serviceType ?? '');
  }

  Widget _schedule() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            contactDetailData(
                AppImages.calender, formatDate(store.model?.schedule)),
            Gap(20.w),
            contactDetailData(
                AppImages.calenderDay, getDayOfWeek(store.model?.schedule)),
          ],
        ),
        Gap(12.h),
        contactDetailData(
            AppImages.clock, getTimeFromTimestamp(store.model?.schedule)),
      ],
    );
  }

  void _navigateToChatPage() {
    if (store.chatId?.isNotEmpty ?? false) {
      context.pushNamed(AppRoutes.chatPage, extra: {AppKeys.id: store.chatId});
    } else {
      controller.add(GetJobChatIdEvent(jobId: store.model?.sId ?? ''));
    }
  }
}
