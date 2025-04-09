import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/filters/filters_model.dart';
import 'package:cobuild/models/jobs/job_pagination_model.dart';
import 'package:cobuild/utils/enums/job_enums.dart';

class JobListingStateStore {
  FiltersModel filtersModel = initFilters();
  JobsListPaginationModel jobsListPaginationModel = JobsListPaginationModel(
    nextHit: 0,
    totalJobCount: 0,
    models: [],
  );

  static FiltersModel initFilters() {
    return FiltersModel(
        status: Map.fromEntries(
          StatusEnum.values.map((e) => MapEntry(e, false)),
        ),
        priority: Map.fromEntries(
          PriorityEnum.values.map((e) => MapEntry(e, false)),
        ),
        selectedSortBy: SortByEnum.desc,
        selectedServiceCategory: []);
  }

  /// Filters
  JobFilterTypes selectedType = JobFilterTypes.status;

  void dispose() {
    selectedType = JobFilterTypes.status;
    jobsListPaginationModel.models.clear();
    jobsListPaginationModel.nextHit = 1;
    jobsListPaginationModel.totalJobCount = 0;
  }
}

class JobListingState extends BlocEventState {
  JobListingStateStore store;
  JobListingState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  int selectedIndex = 0;
  @override
  JobListingState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      JobListingState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
