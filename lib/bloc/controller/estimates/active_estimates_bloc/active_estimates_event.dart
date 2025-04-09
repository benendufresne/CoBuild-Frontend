import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';

abstract class ActiveEstimateEvent extends BlocEvent {
  const ActiveEstimateEvent();
}

class ActiveEstimateInitialEvent extends ActiveEstimateEvent {
  const ActiveEstimateInitialEvent();
}

class GetActiveEstimatesEvent extends ActiveEstimateEvent {
  final bool isNextPage;
  int pageNo;
  GetActiveEstimatesEvent({this.isNextPage = false, this.pageNo = 1});
}

class DeleteActiveEstimatesEvent extends ActiveEstimateEvent {
  final String id;
  const DeleteActiveEstimatesEvent({required this.id});
}

class AddCreatedEstimatesEvent extends ActiveEstimateEvent {
  final EstimateRequestModel model;
  const AddCreatedEstimatesEvent({required this.model});
}

class ClearActiveEstimateDataOnLogout extends ActiveEstimateEvent {
  const ClearActiveEstimateDataOnLogout();
}
