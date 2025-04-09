import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_controller.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_event.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_state.dart';
import 'package:cobuild/bloc/repositories/jobs_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:cobuild/ui/components/jobs/job_card.dart';
import 'package:cobuild/ui/home_page/jobs/job_listing/empty_job_listing.dart';
import 'package:cobuild/ui/shimmer_files/jobs/job_listing_shimmer.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Job listing
class JobListing extends StatefulWidget {
  final bool isHomePageJob;
  const JobListing({super.key, this.isHomePageJob = false});

  @override
  State<StatefulWidget> createState() => _JobListingState();
}

class _JobListingState extends State<JobListing> {
  JobsRepository repo = JobsRepository();
  late JobListingController controller;
  late ScrollController scrollController;
  late JobListingStateStore jobStore;

  @override
  void initState() {
    super.initState();
    controller = context.read<JobListingController>();
    jobStore = controller.state.store;
    _getNearByJobs();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  Future<void> _getNearByJobs() async {
    if (!((controller.state.event is GetAllJobList) &&
        (controller.state.state == BlocState.loading))) {
      _getFirstPageJobs();
    }
  }

  void _getFirstPageJobs() {
    controller.add(GetAllJobList());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if ((scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) &&
        !(controller.state.event is GetAllJobList &&
            controller.state.state == BlocState.loading)) {
      // Fetch the next page
      controller.add(GetAllJobList(isNextPage: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilderNew<JobListingController, JobListingState>(
        loadingView: (blocState) {
          if (controller.isJobListEmpty) {
            return _shimmerView();
          }
          return _body();
        },
        noInternetView: (blocState) {
          if (controller.isJobListEmpty) {
            return NoInternetView(onPressed: _getFirstPageJobs);
          }
          return _body();
        },
        failedView: (blocState) {
          if (controller.isJobListEmpty) {
            return FailedView(onPressed: _getFirstPageJobs);
          }
          return _body();
        },
        defaultView: (blocSate) => _body());
  }

  Widget _shimmerView() {
    return const JobListingShimmer(itemCount: 6);
  }

  Widget _body() {
    if (controller.state.event is JobListingInitialEvent) {
      return _shimmerView();
    }
    if (controller.isJobListEmpty) {
      return Padding(
        padding: widget.isHomePageJob
            ? KEdgeInsets.kOnly(t: deviceHeight * 0.03)
            : EdgeInsets.zero,
        child: EmptyListing(title: S.current.noJobPostedYet),
      );
    }
    return _jobListing();
  }

  Widget _jobListing() {
    return RefreshIndicator(
      onRefresh: () async => _getFirstPageJobs(),
      child: Column(
        children: [
          widget.isHomePageJob
              ? _list()
              : Expanded(
                  child: _list(),
                ),
          if (controller.isLoadingNextPageData) const NextPageDataLoader()
        ],
      ),
    );
  }

  Widget _list() {
    int count = jobStore.jobsListPaginationModel.models.length;
    return ListView.separated(
        controller: scrollController,
        itemCount: widget.isHomePageJob
            ? (count > 5)
                ? 5
                : count
            : count,
        shrinkWrap: true,
        physics: widget.isHomePageJob
            ? const NeverScrollableScrollPhysics()
            : const ClampingScrollPhysics(),
        padding: widget.isHomePageJob
            ? EdgeInsets.zero
            : KEdgeInsets.k(v: pageVerticalPadding),
        separatorBuilder: (context, index) {
          return SizedBox(height: 15.h);
        },
        itemBuilder: (context, index) {
          JobModel model = jobStore.jobsListPaginationModel.models[index];
          return JobCard(model: model);
        });
  }
}
