import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class CableConsultingDataEvent extends BlocEvent {
  const CableConsultingDataEvent();
}

class CableConsultingDataInitialEvent extends CableConsultingDataEvent {
  const CableConsultingDataInitialEvent();
}

class GetCableConsultingDataEvent extends CableConsultingDataEvent {
  GetCableConsultingDataEvent();
}
