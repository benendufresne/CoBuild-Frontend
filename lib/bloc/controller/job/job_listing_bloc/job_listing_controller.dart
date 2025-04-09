import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_controller.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_event.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_event.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_state.dart';
import 'package:cobuild/bloc/repositories/jobs_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobListingController extends Bloc<JobListingEvent, JobListingState> {
  final JobsRepository _repository = JobsRepository();
  JobListingController()
      : super(JobListingState(
            state: BlocState.none,
            event: const JobListingInitialEvent(),
            response: null,
            store: JobListingStateStore())) {
    on<GetAllJobList>(_getJobList);
    on<ApplyFiltersInJobListingEvent>(_applyFilter);
    on<ResetFiltersInJobListingEvent>(_resetFilter);
    on<UpdateJobLocationEvent>(_updateJobLocation);
    on<ClearJobData>(_clearJobData);
  }

  Future<void> _getJobList(
      GetAllJobList event, Emitter<JobListingState> emit) async {
    if ((event.isNextPage &&
            state.store.jobsListPaginationModel.nextHit <= 1) ||
        (!AppPreferences.isLoggedIn)) {
      return;
    }
    // Coordinates , if any locatin selected :-
    event.coordinates = [AppPreferences.longitude, AppPreferences.latitude];
    if (AppPreferences.jobsLongitude != null) {
      event.coordinates![0] = AppPreferences.jobsLongitude!;
    }
    if (AppPreferences.jobsLatitude != null) {
      event.coordinates![1] = AppPreferences.jobsLatitude!;
    }
    int pageNo =
        event.isNextPage ? state.store.jobsListPaginationModel.nextHit : 1;
    event.pageNo = pageNo;
    // Filters
    event.filters = state.store.filtersModel;
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.jobList(event);
    if (response.state == BlocState.success) {
      List<dynamic> list = response.data[ApiKeys.data];

      List<JobModel> jobList = list.map((e) => JobModel.fromJson(e)).toList();
      if (pageNo == 1) {
        state.store.jobsListPaginationModel.models = jobList;
      } else {
        state.store.jobsListPaginationModel.models.addAll(jobList);
      }
      state.store.jobsListPaginationModel.nextHit =
          response.data[ApiKeys.nextHit];
      state.store.jobsListPaginationModel.totalJobCount =
          response.data[ApiKeys.total] ?? 0;
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
    if (response.state == BlocState.success && ctx.mounted) {
      ctx.read<DynamicMapController>().add(UpdateMapViewEvent());
    }
  }

  Future<void> _applyFilter(ApplyFiltersInJobListingEvent event,
      Emitter<JobListingState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    if (event.model != null) {
      state.store.filtersModel = event.model!.copyWith();
    }
    emit(state.copyWith(state: BlocState.success, event: event));
    add(GetAllJobList());
  }

  Future<void> _resetFilter(ResetFiltersInJobListingEvent event,
      Emitter<JobListingState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    state.store.filtersModel = JobListingStateStore.initFilters();
    emit(state.copyWith(state: BlocState.success, event: event));
    add(GetAllJobList());
  }

  Future<void> _updateJobLocation(
      UpdateJobLocationEvent event, Emitter<JobListingState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    await AppPreferences.updateJobAddress(event.model);
    emit(state.copyWith(state: BlocState.success, event: event));
    add(GetAllJobList());
  }

  Future<void> _clearJobData(
      ClearJobData event, Emitter<JobListingState> emit) async {
    state.store.dispose();
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  bool get isLoadingNextPageData {
    if ((state.event is GetAllJobList && state.state == BlocState.loading)) {
      GetAllJobList currentEvent = state.event as GetAllJobList;
      if (currentEvent.isNextPage) {
        return true;
      }
    }
    return false;
  }

  bool get isJobListEmpty =>
      (state.store.jobsListPaginationModel.models.isEmpty);
}
