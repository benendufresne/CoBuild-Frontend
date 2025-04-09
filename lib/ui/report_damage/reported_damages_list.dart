import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_data/damage_report_controller.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_data/damage_report_event.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_data/damage_report_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/chat_icon.dart';
import 'package:cobuild/ui/components/common_floating_button.dart';
import 'package:cobuild/ui/home_page/jobs/job_listing/empty_job_listing.dart';
import 'package:cobuild/ui/report_damage/damage_card.dart';
import 'package:cobuild/ui/shimmer_files/damage_report/reported_damage_list_shimmer.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Reported damage list
class ReportedDamangeList extends StatefulWidget {
  const ReportedDamangeList({super.key});

  @override
  State<StatefulWidget> createState() => _ReportedDamangeListState();
}

class _ReportedDamangeListState extends State<ReportedDamangeList> {
  late DamageReportListingController controller;
  late ReportedDamageListStateStore store;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    controller = context.read<DamageReportListingController>();
    store = controller.state.store;
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    getFirstPageData();
  }

  void getFirstPageData() {
    controller.add(GetDamageReportListEvent());
  }

  void _onScroll() {
    if ((scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) &&
        !(controller.state.event is GetDamageReportListEvent &&
            controller.state.state == BlocState.loading)) {
      // Fetch the next page
      controller.add(GetDamageReportListEvent(isNextPage: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBar(
          title: S.current.reportedDamage,
          actions: [
            Padding(
              padding: KEdgeInsets.kOnly(r: 12.w),
              child: ChatIcon(
                backgroundColor: AppColors.backgroundGrey.withOpacity(0.1),
              ),
            )
          ],
          showBackButton: false),
      floatingActionButton: CommonFloatingButton(onPressed: () {
        context.pushNamed(AppRoutes.damageReportForm);
      }),
      body: Padding(
        padding:
            KEdgeInsets.k(h: pageHorizontalPadding, v: pageVerticalPadding),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return BlocBuilderNew<DamageReportListingController,
            ReportedDamageListState>(
        loadingView: (blocState) {
          if (controller.isDataListEmpty) {
            return _shimmerView();
          }
          return _list();
        },
        noInternetView: (blocState) {
          if (controller.isDataListEmpty) {
            return NoInternetView(onPressed: getFirstPageData);
          }
          return _list();
        },
        failedView: (blocState) {
          if (controller.isDataListEmpty) {
            return FailedView(onPressed: getFirstPageData);
          }
          return _list();
        },
        defaultView: (blocSate) => _list());
  }

  Widget _shimmerView() {
    return const ReportedDamageListShimmer(itemCount: 6);
  }

  Widget _list() {
    if (controller.isDataListEmpty) {
      return EmptyListing(title: S.current.noReportedDamages);
    }
    return RefreshIndicator(
        onRefresh: () async => getFirstPageData(),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: store.list.models.length,
                  controller: scrollController,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.h);
                  },
                  itemBuilder: (context, index) {
                    return DamageCard(model: store.list.models[index]);
                  }),
            ),
            if (controller.isLoadingNextPageData) const NextPageDataLoader()
          ],
        ));
  }
}
