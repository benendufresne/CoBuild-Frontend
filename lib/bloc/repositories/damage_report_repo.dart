import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/controller/report_damage/add_damage_report/add_damage_report_event.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_data/damage_report_event.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_details_bloc/damage_report_details_event.dart';
import 'package:cobuild/bloc/repositories/app_repo.dart';
import 'package:cobuild/utils/api_endpoints.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/services/https_services/http_services.dart';

abstract class DamageReportRepository extends AppRepository {
  static _DamageReportRepositoryImpl? _instance;

  factory DamageReportRepository() {
    return _instance ??= _DamageReportRepositoryImpl();
  }

  /// Add Damage Report
  Future<BlocResponse> addDamageReport(AddDamageReportEvent event);

  /// Get Damage Report List
  Future<BlocResponse> damageReportList(GetDamageReportListEvent event);

  Future<BlocResponse> damageReportDetail(GetDamageReportDetailsEvent event);
}

class _DamageReportRepositoryImpl implements DamageReportRepository {
  int maxRequestsInAPage = 10;
  final HttpServices _apiService = HttpServices();

  @override
  Future<BlocResponse> addDamageReport(AddDamageReportEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        apiEndPoint: ApiEndpoints.reportDamange, body: event.model.toJson());
    return response;
  }

  @override
  Future<BlocResponse> damageReportList(GetDamageReportListEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.reportDamangeList,
        queryParams: {
          ApiKeys.pageNo: event.pageNo,
          ApiKeys.limit: maxRequestsInAPage
        },
        body: {});
    return response;
  }

  @override
  Future<BlocResponse> damageReportDetail(
      GetDamageReportDetailsEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.reportDamange,
        queryParams: {
          ApiKeys.reportId: event.damageReportId,
        },
        body: {});
    return response;
  }

  ///clear data on logout
  @override
  Future<void> clearDataOnLogout() async {}
}
