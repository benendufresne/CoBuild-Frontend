import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class CompletedEstimateEvent extends BlocEvent {
  const CompletedEstimateEvent();
}

class CompletedEstimateInitialEvent extends CompletedEstimateEvent {
  const CompletedEstimateInitialEvent();
}

class GetCompletedEstimatesEvent extends CompletedEstimateEvent {
  final bool isNextPage;
  int pageNo;
  GetCompletedEstimatesEvent({this.isNextPage = false, this.pageNo = 1});
}

class DeleteCompletedEstimatesEvent extends CompletedEstimateEvent {
  final String id;
  const DeleteCompletedEstimatesEvent({required this.id});
}

class ClearCompletedEstimateDataOnLogout extends CompletedEstimateEvent {
  const ClearCompletedEstimateDataOnLogout();
}
