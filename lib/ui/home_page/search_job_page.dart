import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/job/search_jobs_bloc/search_jobs_controller.dart';
import 'package:cobuild/bloc/controller/job/search_jobs_bloc/search_jobs_event.dart';
import 'package:cobuild/bloc/controller/job/search_jobs_bloc/search_jobs_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/common_widgets.dart';
import 'package:cobuild/ui/components/jobs/job_card.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/components/text_fields/address_text_field.dart';
import 'package:cobuild/ui/shimmer_files/jobs/job_listing_shimmer.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_helpers/debouncer.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

class SearchJobScreen extends StatefulWidget {
  const SearchJobScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchJobScreenState();
}

class _SearchJobScreenState extends State<SearchJobScreen> {
  late SearchJobsController controller;
  late SearchJobsStateStore store;
  final DeBouncer deBouncer = DeBouncer(milliseconds: 800);
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    controller = context.read<SearchJobsController>();
    store = controller.state.store;
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if ((scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) &&
        !(controller.state.event is SearchJobEvent &&
            controller.state.state == BlocState.loading)) {
      // Fetch the next page
      _searchData(isNextPage: true);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBar(title: S.current.search),
      bottomSheet: _searchButton(),
      body: SingleChildScrollView(
        padding: KEdgeInsets.kOnly(
            t: pageVerticalPadding,
            l: pageHorizontalPadding,
            r: pageHorizontalPadding,
            b: pageVerticalPadding + 88.h),
        controller: scrollController,
        child: Column(
          children: [
            AppTextField(
              hintText: S.current.searchByNameTitle,
              controller: store.searchJobByNameController,
              prefixWidget: Padding(
                padding: EdgeInsets.fromLTRB(12.h, 16.h, 8.h, 16.h),
                child: CommonWidgets.searchIcon(),
              ),
              onChange: (value) {
                setState(() {});
              },
            ),
            Gap(fieldGap),
            AddressTextField(
              hintText: S.current.enterLocationManually,
              controller: store.searchJobByLocationController,
              focusNode: store.searchJobByLocationFocus,
              isRequired: false,
              locationModel: store.locationModel,
              showSiffixIcon: true,
              showPrefixIcon: true,
              callBack: () {
                setState(() {});
              },
            ),
            Gap(fieldGap),
            _searchWidget(),
          ],
        ),
      ),
    );
  }

  Widget _searchButton() {
    return Container(
      color: AppColors.white,
      padding: KEdgeInsets.k(v: 18.h, h: 24.w),
      child: AppCommonButton(
          isEnable: ((store.searchJobByNameController.text.length > 1) ||
              (store.locationModel?.address?.isNotEmpty ?? false)),
          buttonName: S.current.search,
          isLoading: (controller.state.event is SearchJobEvent &&
              controller.state.state == BlocState.loading),
          onPressed: () {
            _searchData();
          },
          isExpanded: true),
    );
  }

  void _searchData({bool isNextPage = false}) {
    controller.add(SearchJobEvent(
        searchText: store.searchJobByNameController.text.trim(),
        coordinates: store.locationModel?.coordinates,
        isNextPage: isNextPage));
  }

  Widget _searchWidget() {
    return BlocBuilderNew<SearchJobsController, SearchJobsState>(
        loadingView: (blocState) {
          if (store.list.models.isEmpty &&
              (blocState.event is SearchJobEvent)) {
            return const JobListingShimmer(itemCount: 5);
          } else {
            return _jobList();
          }
        },
        successView: (blocState) {
          if (!controller.isSearchDataEmpty && store.list.models.isEmpty) {
            return Center(
              child: Padding(
                padding: KEdgeInsets.k(v: majorGapVertical),
                child: Header2(heading: S.current.nodataFound),
              ),
            );
          }
          return _jobList();
        },
        defaultView: (blocSate) => _jobList());
  }

  Widget _jobList() {
    return Column(
      children: [
        ListView.separated(
            itemCount: store.list.models.length,
            shrinkWrap: true,
            padding: KEdgeInsets.kOnly(b: pageVerticalPadding),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return SizedBox(height: 15.h);
            },
            itemBuilder: (context, index) {
              JobModel model = store.list.models[index];
              return JobCard(model: model);
            }),
        if (controller.isLoadingNextPageData) const NextPageDataLoader()
      ],
    );
  }
}
