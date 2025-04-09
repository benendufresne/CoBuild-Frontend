import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_controller.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_state.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_controller.dart';
import 'package:cobuild/bloc/repositories/jobs_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/text/hearder2.dart';
import 'package:cobuild/ui/components/text/link_text.dart';
import 'package:cobuild/ui/home_page/estimate_and_discover_card.dart';
import 'package:cobuild/ui/home_page/home_page_header.dart';
import 'package:cobuild/ui/home_page/jobs/job_listing/job_listing.dart';
import 'package:cobuild/ui/home_page/scan_job/scan_job_card.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main Home page of application
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late JobListingController jobListingController;
  late ServiceCategoryController serviceCategoryController;
  // late ScrollController scrollController;
  JobsRepository jobRepo = JobsRepository();
  late JobListingStateStore jobStore;

  @override
  void initState() {
    super.initState();
    jobListingController = context.read<JobListingController>();
    jobStore = jobListingController.state.store;
    serviceCategoryController = context.read<ServiceCategoryController>();
    // scrollController = ScrollController();
    // scrollController.addListener(_onScroll);
  }

  // void _onScroll() {
  //   if ((scrollController.position.pixels >=
  //           scrollController.position.maxScrollExtent - 100) &&
  //       !(jobListingController.state.event is GetAllJobList &&
  //           jobListingController.state.state == BlocState.loading)) {
  //     if (jobStore.jobsListPaginationModel.models.length < maxJobInAPage) {
  //       return;
  //     }
  //     // Fetch the next page
  //     jobListingController.add(GetAllJobList(isNextPage: true));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      // controller: scrollController,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 15.h),
      child: Column(
        children: [
          const HomePageHeader(),
          Padding(
            padding: KEdgeInsets.k(h: pageHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(18.h),
                const ScanJobCard(),
                Gap(18.h),
                _title(S.current.estimatesAndDiscover),
                Gap(15.h),
                const EstimateAndDiscoverCard(),
                Gap(18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _title(S.current.nearbyJobs),
                    BlocBuilderNew<JobListingController, JobListingState>(
                        defaultView: (blocState) => blocState
                                .store.jobsListPaginationModel.models.isEmpty
                            ? const SizedBox()
                            : LinkText(
                                text: S.current.viewAll,
                                onTap: () {
                                  context.pushNamed(AppRoutes.nearByJobs);
                                }))
                  ],
                ),
                Gap(15.h),
                const JobListing(isHomePageJob: true)
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _title(String title) {
    return Header2(heading: title, fontSize: 18);
  }
}
