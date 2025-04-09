import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:cobuild/models/jobs/job_pagination_model.dart';
import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';

class SearchJobsStateStore {
  /// For Search Job page
  final FocusNode searchJobByNameFocus = FocusNode();
  final FocusNode searchJobByLocationFocus = FocusNode();

  ValidatedController searchJobByNameController = ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );
  ValidatedController searchJobByLocationController =
      ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );

  LocationModel? locationModel = LocationModel();

  JobsListPaginationModel list =
      JobsListPaginationModel(models: <JobModel>[], nextHit: 1);

  void dispose() {
    searchJobByNameController.dispose();
    searchJobByLocationController.dispose();
  }
}

class SearchJobsState extends BlocEventState {
  SearchJobsStateStore store;
  SearchJobsState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  int selectedIndex = 0;
  @override
  SearchJobsState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      SearchJobsState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
