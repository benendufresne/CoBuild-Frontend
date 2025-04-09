import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/job/search_jobs_bloc/search_jobs_event.dart';
import 'package:cobuild/bloc/controller/job/search_jobs_bloc/search_jobs_state.dart';
import 'package:cobuild/bloc/repositories/jobs_repo.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchJobsController extends Bloc<SearchJobBaseEvent, SearchJobsState> {
  final JobsRepository _repository = JobsRepository();
  SearchJobsController()
      : super(SearchJobsState(
            state: BlocState.none,
            event: const SearchJobInitialEvent(),
            response: null,
            store: SearchJobsStateStore())) {
    on<SearchJobEvent>(_searchJobs);
  }

  Future<void> _searchJobs(
      SearchJobEvent event, Emitter<SearchJobsState> emit) async {
    if (event.isNextPage && state.store.list.nextHit <= 1) {
      return;
    }
    emit(state.copyWith(state: BlocState.loading, event: event));
    if (event.isNextPage) {
      event.pageNo = state.store.list.nextHit;
    }
    if (isSearchDataEmpty) {
      state.store.list.models.clear();
      emit(state.copyWith(state: BlocState.success, event: event));
      return;
    }
    BlocResponse response = await _repository.searchJobs(event);
    if (response.state == BlocState.success) {
      List<dynamic> list = response.data[ApiKeys.data];
      List<JobModel> jobList = list.map((e) => JobModel.fromJson(e)).toList();
      if (event.pageNo == 1) {
        state.store.list.models = jobList;
      } else {
        state.store.list.models.addAll(jobList);
      }
      state.store.list.nextHit = response.data[ApiKeys.nextHit];
    }
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  bool get isLoadingNextPageData {
    if ((state.event is SearchJobEvent && state.state == BlocState.loading)) {
      SearchJobEvent currentEvent = state.event as SearchJobEvent;
      if (currentEvent.isNextPage) {
        return true;
      }
    }
    return false;
  }

  bool get isSearchDataEmpty =>
      (state.store.searchJobByNameController.text.trim().isEmpty) &&
      (state.store.locationModel?.coordinates?.isEmpty ?? true);
}
