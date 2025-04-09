import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class EstimateDetailsEvent extends BlocEvent {
  const EstimateDetailsEvent();
}

class EstimateDetailsInitialEvent extends EstimateDetailsEvent {
  const EstimateDetailsInitialEvent();
}

/// Get Estimates Details
class GetEstimateDetailsEvent extends EstimateDetailsEvent {
  String estimateId;
  GetEstimateDetailsEvent({required this.estimateId});
}
