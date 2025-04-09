import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';

class UploadMediaStateStore {
  void dispose() {}
}

class UploadMediaState extends BlocEventState {
  UploadMediaStateStore store;
  UploadMediaState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  UploadMediaState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      UploadMediaState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
