import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/chat/chat_room_model/chat_room_model.dart';
import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';

class ChatPageStateStore {
  ChatRoomModel? chatRoomModel;
  List<MessageModel> messagesList = [];
  ValidatedController messageController = ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );
  void dispose() {
    chatRoomModel = null;
    messagesList.clear();
    messageController.clear();
  }
}

class ChatPageState extends BlocEventState {
  ChatPageState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.stateStore});
  ChatPageStateStore stateStore;
  @override
  ChatPageState copyWith({BlocState? state, BlocEvent? event}) {
    return ChatPageState(
        event: event ?? event,
        state: state ?? this.state,
        stateStore: stateStore);
  }
}
