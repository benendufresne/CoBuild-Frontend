import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/models/estimates/cable_consulting_data/cable_consulting_model/cable_consulting_model.dart';
import 'package:cobuild/models/service_category/service_category.dart';

class ServiceCategoryStateStore {
  List<ServiceCategoryModel> categoryList = [];
  List<ServiceCategoryModel> searchList = [];

  /// Cable consulting data :-
  CableConsultingModel? cableConsultingModel;
  void dispose() {
    categoryList.clear();
    searchList.clear();
  }
}

class ServiceCategoryState extends BlocEventState {
  ServiceCategoryStateStore store;
  ServiceCategoryState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.store});
  @override
  ServiceCategoryState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      ServiceCategoryState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          store: store);
}
