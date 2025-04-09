import 'dart:async';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_event.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_state.dart';
import 'package:cobuild/bloc/repositories/jobs_repo.dart';
import 'package:cobuild/models/estimates/cable_consulting_data/cable_consulting_model/cable_consulting_model.dart';
import 'package:cobuild/models/service_category/service_category.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceCategoryController
    extends Bloc<ServiceCategoryEvent, ServiceCategoryState> {
  final JobsRepository _repository = JobsRepository();
  ServiceCategoryController()
      : super(ServiceCategoryState(
            state: BlocState.none,
            event: const ServiceCategoryInitialEvent(),
            response: null,
            store: ServiceCategoryStateStore())) {
    on<GetServiceCategoryListEvent>(_getServiceCategoryList);
    on<SearchServiceCategoryEvent>(_searchServiceCategory);
    on<GetCableConsultingDataEvent>(_getCableConsultingData);
  }

  Future<void> _getServiceCategoryList(GetServiceCategoryListEvent event,
      Emitter<ServiceCategoryState> emit) async {
    // if (state.store.categoryList.isNotEmpty) {
    //   return;
    // }
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.getServiceCategory(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
    if (response.state == BlocState.success) {
      if (event.type == ServiceTypeEnum.categoryService) {
        List<dynamic> data = response.data[ApiKeys.data];
        List<ServiceCategoryModel> list =
            data.map((e) => ServiceCategoryModel.fromJson(e)).toList();
        state.store.categoryList = list;
      } else if (event.type == ServiceTypeEnum.cableConsultingService) {
        state.store.cableConsultingModel =
            CableConsultingModel.fromJson(response.data);
      }
    }
  }

  Future<void> _searchServiceCategory(SearchServiceCategoryEvent event,
      Emitter<ServiceCategoryState> emit) async {
    state.store.searchList.clear();
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.searchServiceCategory(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
    if (response.state == BlocState.success) {
      List<dynamic> data = response.data[ApiKeys.data];
      List<ServiceCategoryModel> list =
          data.map((e) => ServiceCategoryModel.fromJson(e)).toList();
      state.store.searchList = list;
    }
  }

  Future<void> _getCableConsultingData(GetCableConsultingDataEvent event,
      Emitter<ServiceCategoryState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.getCableConsultingData(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
    if (response.state == BlocState.success) {
      state.store.cableConsultingModel =
          CableConsultingModel.fromJson(response.data);
    }
  }

  bool get isCategoryListEmpty => state.store.categoryList.isEmpty;
}
