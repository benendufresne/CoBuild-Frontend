import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class EstimateEvent extends BlocEvent {
  const EstimateEvent();
}

class EstimateInitialEvent extends EstimateEvent {
  const EstimateInitialEvent();
}

class DeleteEstimateRequestEvent extends EstimateEvent {
  final bool isCompleted;
  final String estimateId;

  const DeleteEstimateRequestEvent(
      {this.isCompleted = false, required this.estimateId});
}
