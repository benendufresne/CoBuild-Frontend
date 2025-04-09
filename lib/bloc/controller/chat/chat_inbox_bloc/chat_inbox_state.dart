import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/chat/chat_inbox/chat_inbox_pagination_model.dart';

class ChatInboxListStateStore {
  ChatInboxListPaginationModel list =
      ChatInboxListPaginationModel(models: [], nextHit: 0);
  bool isUnRead = false;

  void dispose() {
    list.models.clear();
    list.nextHit = 1;
    isUnRead = false;
  }
}

class ChatInboxListState extends BlocEventState {
  ChatInboxListState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.stateStore});

  ChatInboxListStateStore stateStore;

  @override
  ChatInboxListState copyWith({
    BlocState? state,
    BlocEvent? event,
  }) {
    return ChatInboxListState(
        event: event ?? event,
        state: state ?? this.state,
        stateStore: stateStore);
  }
}
