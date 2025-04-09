import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/jobs/job_model.dart';

class JobDetailsStateStore {
  JobModel? model;
  String? chatId;

  void dispose() {
    model = null;
    chatId = null;
  }
}

class JobDetailsState extends BlocEventState {
  JobDetailsStateStore store;
  JobDetailsState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  JobDetailsState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      JobDetailsState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
