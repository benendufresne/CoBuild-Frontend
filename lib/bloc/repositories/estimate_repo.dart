import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_controller.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_event.dart';
import 'package:cobuild/bloc/controller/estimates/cable_consulting_data_bloc/cable_consulting_data_event.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_estimate_controller.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_estimate_state.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_details_bloc/estimate_details_event.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_event.dart';
import 'package:cobuild/bloc/controller/estimates/estimates_bloc/estimate_evevt.dart';
import 'package:cobuild/bloc/repositories/app_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/utils/api_endpoints.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/services/https_services/http_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class EstimateRepository extends AppRepository {
  static _EstimateRepositoryImpl? _instance;

  factory EstimateRepository() {
    return _instance ??= _EstimateRepositoryImpl();
  }

  /// Create Estimates Request
  Future<BlocResponse> createEstimateRequest(CreateEstimateRequestEvent event);
  Future<BlocResponse> updateEstimateRequest(UpdateEstimateRequestEvent event);
  Future<BlocResponse> deleteEstimateRequest(DeleteEstimateRequestEvent event);

  /// Get Active Estimates List
  Future<BlocResponse> getActiveEstimatesList(GetActiveEstimatesEvent event);

  Future<BlocResponse> getCompletedEstimateList(
      GetCompletedEstimatesEvent event);

  Future<BlocResponse> getEstimateDetails(GetEstimateDetailsEvent event);

  // Cable consulting
  Future<BlocResponse> getCableConsultingData(
      GetCableConsultingDataEvent event);
}

class _EstimateRepositoryImpl implements EstimateRepository {
  int maxRequestsInAPage = 10;
  final HttpServices _apiService = HttpServices();

  @override
  Future<BlocResponse> createEstimateRequest(
      CreateEstimateRequestEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        apiEndPoint: ApiEndpoints.estimateRequest, body: event.model.toJson());
    if (response.state == BlocState.success) {}
    return response;
  }

  @override
  Future<BlocResponse> updateEstimateRequest(
      UpdateEstimateRequestEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPut, event,
        apiEndPoint: ApiEndpoints.estimateRequest, body: event.model.toJson());
    if (response.state == BlocState.success) {}
    return response;
  }

  @override
  Future<BlocResponse> deleteEstimateRequest(
      DeleteEstimateRequestEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPut, event,
        apiEndPoint: ApiEndpoints.estimateRequest,
        body: {ApiKeys.reqId: event.estimateId, ApiKeys.status: "DELETED"});
    return response;
  }

  @override
  Future<BlocResponse> getActiveEstimatesList(
      GetActiveEstimatesEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.estimateList,
        queryParams: {
          ApiKeys.pageNo: event.pageNo,
          ApiKeys.limit: maxRequestsInAPage,
          ApiKeys.isActive: true
        },
        body: {});
    return response;
  }

  @override
  Future<BlocResponse> getCompletedEstimateList(
      GetCompletedEstimatesEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.estimateList,
        queryParams: {
          ApiKeys.pageNo: event.pageNo,
          ApiKeys.limit: maxRequestsInAPage,
          ApiKeys.isCompleted: true
        },
        body: {});
    return response;
  }

  @override
  Future<BlocResponse> getEstimateDetails(GetEstimateDetailsEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.estimateRequest,
        queryParams: {ApiKeys.reqId: event.estimateId},
        body: {});
    return response;
  }

  @override
  Future<BlocResponse> getCableConsultingData(
      GetCableConsultingDataEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.estimateRequest, body: {});
    if (response.state == BlocState.success) {}
    return response;
  }

  ///clear data on logout
  @override
  Future<void> clearDataOnLogout() async {
    ctx
        .read<ActiveEstimateController>()
        .add(const ClearActiveEstimateDataOnLogout());
    ctx
        .read<CompletedEstimateController>()
        .add(const ClearCompletedEstimateDataOnLogout());
  }
}
