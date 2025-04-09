import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_estimate_controller.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_estimate_state.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_extimate_event.dart';
import 'package:cobuild/ui/estimates/estimate_listing/estimate_listing.dart';
import 'package:cobuild/ui/home_page/jobs/job_listing/empty_job_listing.dart';
import 'package:cobuild/ui/shimmer_files/estimate_requests/estimates_listing_shimmer.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Show Listing of completed estimate requests
class CompletedEstimateRequests extends StatefulWidget {
  const CompletedEstimateRequests({super.key});

  @override
  State<StatefulWidget> createState() => _CompletedEstimateRequestsState();
}

class _CompletedEstimateRequestsState extends State<CompletedEstimateRequests> {
  late CompletedEstimateController controller;
  late ScrollController scrollController;
  late CompletedEstimateStateStore store;

  @override
  void initState() {
    super.initState();
    controller = context.read<CompletedEstimateController>();
    store = controller.state.store;
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    _getInitData();
  }

  Future<void> _getInitData() async {
    if (!((controller.state.event is GetCompletedEstimatesEvent) &&
        (controller.state.state == BlocState.loading))) {
      getFirstPageData();
    }
  }

  void getFirstPageData() {
    controller.add(GetCompletedEstimatesEvent());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if ((scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) &&
        !(controller.state.event is GetCompletedEstimatesEvent &&
            controller.state.state == BlocState.loading)) {
      // Fetch the next page
      controller.add(GetCompletedEstimatesEvent(isNextPage: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilderNew<CompletedEstimateController, CompletedEstimateState>(
        loadingView: (blocState) {
          if (controller.isDataListEmpty) {
            return _shimmerView();
          }
          return _body();
        },
        noInternetView: (blocState) {
          if (controller.isDataListEmpty) {
            return NoInternetView(onPressed: getFirstPageData);
          }
          return _body();
        },
        failedView: (blocState) {
          if (controller.isDataListEmpty) {
            return FailedView(onPressed: getFirstPageData);
          }
          return _body();
        },
        defaultView: (blocSate) => _body());
  }

  Widget _shimmerView() {
    return const EstimateListingShimmer(itemCount: 6);
  }

  Widget _body() {
    if (controller.state.event is CompletedEstimateInitialEvent) {
      return _shimmerView();
    }
    if (controller.isDataListEmpty) {
      return EmptyListing(title: S.current.noEstimateRequest);
    }
    return _jobListing();
  }

  Widget _jobListing() {
    return RefreshIndicator(
      onRefresh: () async => getFirstPageData(),
      child: Column(
        children: [
          Expanded(
            child: EstimateListing(
              controller: scrollController,
              list: store.list.models,
            ),
          ),
          if (controller.isLoadingNextPageData) const NextPageDataLoader()
        ],
      ),
    );
  }
}
