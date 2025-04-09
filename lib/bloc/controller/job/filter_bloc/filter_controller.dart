import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/job/filter_bloc/filter_event.dart';
import 'package:cobuild/bloc/controller/job/filter_bloc/filter_state.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_controller.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_event.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/filters/filters_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterController extends Bloc<FilterEvents, FilterState> {
  FilterController()
      : super(FilterState(
            state: BlocState.none,
            event: const FilterInitialEvent(),
            response: null,
            store: FilterStateStore())) {
    on<InitPreApplyFiltersEvent>(_initPreApplyFilters);
    on<ApplyFiltersEvent>(_applyFilters);
    on<ResetFiltersEvent>(_resetFilters);
    on<ChangeSelectedFilterTypeEvent>(_changeFilterType);
    on<AddCategoryFilterEvent>(_addCategoryFilter);
  }

  Future<void> _initPreApplyFilters(
      InitPreApplyFiltersEvent event, Emitter<FilterState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    FiltersModel filtersModel =
        ctx.read<JobListingController>().state.store.filtersModel;
    state.store.filtersModel = filtersModel.copyWith();
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  Future<void> _applyFilters(
      ApplyFiltersEvent event, Emitter<FilterState> emit) async {
    ctx
        .read<JobListingController>()
        .add(ApplyFiltersInJobListingEvent(model: state.store.filtersModel));
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  Future<void> _resetFilters(
      ResetFiltersEvent event, Emitter<FilterState> emit) async {
    ctx.read<JobListingController>().add(ResetFiltersInJobListingEvent());
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  Future<void> _changeFilterType(
      ChangeSelectedFilterTypeEvent event, Emitter<FilterState> emit) async {
    if (event.type == state.store.selectedType) {
      return;
    }
    state.store.selectedType = event.type;
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  Future<void> _addCategoryFilter(
      AddCategoryFilterEvent event, Emitter<FilterState> emit) async {
    if (state.store.filtersModel?.selectedServiceCategory.contains(event.id) ??
        false) {
      state.store.filtersModel?.selectedServiceCategory.remove(event.id);
    } else {
      state.store.filtersModel?.selectedServiceCategory.add(event.id);
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }
}
