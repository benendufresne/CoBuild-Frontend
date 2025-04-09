import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/utils/enums/job_enums.dart';

abstract class FilterEvents extends BlocEvent {
  const FilterEvents();
}

class FilterInitialEvent extends FilterEvents {
  const FilterInitialEvent();
}

class InitPreApplyFiltersEvent extends FilterEvents {
  InitPreApplyFiltersEvent();
}

class ApplyFiltersEvent extends FilterEvents {
  ApplyFiltersEvent();
}

class ResetFiltersEvent extends FilterEvents {
  ResetFiltersEvent();
}

/// Filter events
class ChangeSelectedFilterTypeEvent extends FilterEvents {
  final JobFilterTypes type;
  ChangeSelectedFilterTypeEvent({required this.type});
}

class AddCategoryFilterEvent extends FilterEvents {
  final String id;
  AddCategoryFilterEvent({required this.id});
}
