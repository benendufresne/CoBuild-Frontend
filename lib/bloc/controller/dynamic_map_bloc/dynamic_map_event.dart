import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/jobs/job_model.dart';

abstract class DynamicMapEvent extends BlocEvent {
  const DynamicMapEvent();
}

class DynamicMapInitialEvent extends DynamicMapEvent {
  const DynamicMapInitialEvent();
}

class SetInitialJobLocationEvent extends DynamicMapEvent {
  final JobModel? jobModel;
  const SetInitialJobLocationEvent({required this.jobModel});
}

class OnTapJobMarkerEvent extends DynamicMapEvent {
  final JobModel? jobModel;
  const OnTapJobMarkerEvent({required this.jobModel});
}

class CloseSeleectedJobOnMapEvent extends DynamicMapEvent {
  const CloseSeleectedJobOnMapEvent();
}

class ClearMapDataEvent extends DynamicMapEvent {
  ClearMapDataEvent();
}

class UpdateMapViewEvent extends DynamicMapEvent {
  final bool initPage;
  UpdateMapViewEvent({this.initPage = true});
}
