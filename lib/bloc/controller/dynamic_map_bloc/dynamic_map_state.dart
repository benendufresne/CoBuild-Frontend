import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DynamicMapStateStore {
  final List<Marker> marker = [];
  final List<JobModel> jobList = [];
  JobModel? selectedJobModel;
  void dispose() {}
}

class DynamicMapState extends BlocEventState {
  DynamicMapStateStore store;
  DynamicMapState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  DynamicMapState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      DynamicMapState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
