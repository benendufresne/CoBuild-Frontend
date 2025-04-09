import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/filters/filters_model.dart';
import 'package:cobuild/utils/enums/job_enums.dart';

class FilterStateStore {
  FiltersModel? filtersModel;

  /// Filters
  JobFilterTypes selectedType = JobFilterTypes.status;
  void dispose() {}
}

class FilterState extends BlocEventState {
  FilterStateStore store;
  FilterState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  FilterState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      FilterState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
