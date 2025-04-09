import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';

abstract class ServiceCategoryEvent extends BlocEvent {
  const ServiceCategoryEvent();
}

class ServiceCategoryInitialEvent extends ServiceCategoryEvent {
  const ServiceCategoryInitialEvent();
}

/// Get Service Category List
class GetServiceCategoryListEvent extends ServiceCategoryEvent {
  final ServiceTypeEnum type;
  const GetServiceCategoryListEvent({required this.type});
}

class GetCableConsultingDataEvent extends ServiceCategoryEvent {
  const GetCableConsultingDataEvent();
}

class SearchServiceCategoryEvent extends ServiceCategoryEvent {
  final String key;
  final ServiceTypeEnum type;
  const SearchServiceCategoryEvent({required this.key, required this.type});
}
