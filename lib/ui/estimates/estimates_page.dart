import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_controller.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_event.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_estimate_controller.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_estimate_state.dart';
import 'package:cobuild/ui/components/chat_icon.dart';
import 'package:cobuild/ui/components/custom_tab_bar/common_tabbar.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/common_floating_button.dart';
import 'package:cobuild/ui/estimates/estimate_listing/active_request.dart';
import 'package:cobuild/ui/estimates/estimate_listing/completed_requests.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Main estimate page, that will show active and completed estimate requests
/// along with create new estimate request option.
class EstimatesPage extends StatefulWidget {
  const EstimatesPage({super.key});

  @override
  State<EstimatesPage> createState() => _EstimatesPageState();
}

class _EstimatesPageState extends State<EstimatesPage> {
  late ActiveEstimateController activeController;
  late CompletedEstimateController completedController;

  @override
  void initState() {
    super.initState();
    activeController = context.read<ActiveEstimateController>();
    completedController = context.read<CompletedEstimateController>();
    _getInitData();
  }

  void _getInitData() {
    activeController.add(GetActiveEstimatesEvent());
    completedController.add(GetCompletedEstimatesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBar(title: S.current.estimates, actions: [
        Padding(
          padding: KEdgeInsets.kOnly(r: 20.w),
          child: ChatIcon(
            backgroundColor: AppColors.backgroundGrey.withOpacity(0.1),
          ),
        )
      ]),
      floatingActionButton: CommonFloatingButton(onPressed: () {
        context.pushNamed(AppRoutes.estimatesRequestForm);
      }),
      body: _body(),
    );
  }

  Widget _body() {
    return CustomTabBar(
      tabViews: [
        Padding(
            padding: KEdgeInsets.k20, child: const ActiveEstimateRequests()),
        Padding(
            padding: KEdgeInsets.k20, child: const CompletedEstimateRequests())
      ],
      tabs: [S.current.activeRequest, S.current.acceptedRequests],
    );
  }
}
