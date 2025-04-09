import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/notification_bloc/notification_controller.dart';
import 'package:cobuild/bloc/controller/notification_bloc/notification_event.dart';
import 'package:cobuild/bloc/controller/notification_bloc/notification_state.dart';
import 'package:cobuild/bloc/repositories/notifications_repo.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/notifications/no_notifications.dart';
import 'package:cobuild/ui/notifications/notification_card.dart';
import 'package:cobuild/ui/shimmer_files/notification_list_shimmer.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/ui/widgets/failed_view.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Notifications Main screen
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late NotificationsController controller;
  late ScrollController scrollController;
  late NotificationsStateStore store;

  @override
  void initState() {
    super.initState();
    controller = context.read<NotificationsController>();
    store = controller.state.store;
    _getInitList();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if ((scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) &&
        !(controller.state.event is GetNotificationsEvent &&
            controller.state.state == BlocState.loading)) {
      if (store.notifocationsListPaginationModel.models.length <
          maxNotificationsInAPage) {
        return;
      }
      // Fetch the next page
      controller.add(GetNotificationsEvent(isNextPage: true));
    }
  }

  void _getInitList() {
    controller.add(GetNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBar(
          title: S.current.notifications,
          actions: [_clearAllOption()],
          showBackButton: false),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocBuilderNew<NotificationsController, NotificationsState>(
        onSuccess: (blocState) {
      if (blocState.event is DeleteNotificationEvent) {
      } else if (blocState.event is ClearAllNotificationsEvent) {}
    }, failedView: (blocState) {
      if ((blocState.state == BlocState.failed) &&
          (blocState.event is GetNotificationsEvent) &&
          (controller.isEmptyList)) {
        return FailedView(onPressed: () {
          _getInitList();
        });
      }
      return _notificationListing();
    }, loadingView: (blocState) {
      if (controller.isEmptyList &&
          (blocState.event is GetNotificationsEvent)) {
        return _shimmerView();
      }
      return _notificationListing();
    }, noInternetView: (blocState) {
      if (controller.isEmptyList) {
        return NoInternetView(onPressed: () {
          _getInitList();
        });
      }
      return _notificationListing();
    }, defaultView: (blocState) {
      return _notificationListing();
    });
  }

  Widget _shimmerView() {
    return Padding(
      padding: KEdgeInsets.k20,
      child: const NotificationListingShimmer(itemCount: 10),
    );
  }

  Widget _notificationListing() {
    if (controller.state.event is NotificationsInitialEvent) {
      return _shimmerView();
    }
    if (controller.isEmptyList) {
      return const NoNotifications();
    }
    return Stack(children: [
      RefreshIndicator(
          onRefresh: () async => _getInitList(),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: KEdgeInsets.k20,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  itemCount:
                      store.notifocationsListPaginationModel.models.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.h);
                  },
                  itemBuilder: (context, index) {
                    return NotificationCard(
                        model: store
                            .notifocationsListPaginationModel.models[index]);
                  },
                ),
              ),
              if (controller.isLoadingNextPageData) const NextPageDataLoader()
            ],
          )),
      if ((controller.state.state == BlocState.loading) &&
          (controller.state.event is DeleteNotificationEvent ||
              controller.state.event is ClearAllNotificationsEvent))
        const Center(child: CommonLoader())
    ]);
  }

  Widget _clearAllOption() {
    return BlocBuilderNew<NotificationsController, NotificationsState>(
        defaultView: (blocState) {
      if (controller.isEmptyList) {
        return const SizedBox();
      }
      return IconButton(
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        padding: KEdgeInsets.kOnly(r: 12.w),
        onPressed: _clearAllDialog,
        icon: Text(S.current.clearAll,
            style: AppStyles().regularBold.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline)),
      );
    });
  }

  void _clearAllDialog() {
    DialogBox().commonDialog(
      title: S.current.clearAllNotifications,
      subtitle: S.current.clearAllNotificationsDescription,
      positiveText: S.current.confirm,
      negativeText: S.current.cancel,
      onTapPositive: _clearAllNotification,
    );
  }

  void _clearAllNotification() {
    context.pop();
    controller.add(const ClearAllNotificationsEvent());
  }
}
