import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';

class EstimateRequestListPaginationModel {
  List<EstimateRequestModel> models;
  int nextHit;

  EstimateRequestListPaginationModel(
      {required this.models, required this.nextHit});
}
