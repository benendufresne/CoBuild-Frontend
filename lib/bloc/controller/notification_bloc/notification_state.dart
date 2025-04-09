import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/notifications/notification_pagination_model.dart';

class NotificationsStateStore {
  NotificationsListPaginationModel notifocationsListPaginationModel =
      NotificationsListPaginationModel(models: [], nextHit: 1);
  void dispose() {
    notifocationsListPaginationModel.models.clear();
    notifocationsListPaginationModel.nextHit = 1;
  }
}

class NotificationsState extends BlocEventState {
  NotificationsStateStore store;
  NotificationsState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  NotificationsState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      NotificationsState(
          state: state ?? BlocState.none,
          event: event ?? this.event,
          response: response ?? this.response,
          store: store);
}
