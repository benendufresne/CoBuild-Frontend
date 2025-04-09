import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_controller.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_event.dart';
import 'package:cobuild/bloc/controller/job/job_details/job_details_event.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_controller.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_event.dart';
import 'package:cobuild/bloc/controller/job/search_jobs_bloc/search_jobs_event.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_event.dart';
import 'package:cobuild/bloc/repositories/app_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/filters/filters_model.dart';
import 'package:cobuild/utils/api_endpoints.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';
import 'package:cobuild/utils/enums/job_enums.dart';
import 'package:cobuild/utils/services/https_services/http_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int maxJobInAPage = 100;

abstract class JobsRepository extends AppRepository {
  static _JobsRepositoryImpl? _instance;

  factory JobsRepository() {
    return _instance ??= _JobsRepositoryImpl();
  }

  /// Search Jobs
  Future<BlocResponse> searchJobs(SearchJobEvent event);

  /// Get Job Details
  Future<BlocResponse> jobDetails(GetJobDetailsEvent event);

  /// Get Jobs List
  Future<BlocResponse> jobList(GetAllJobList event);

  // Get Service Category
  Future<BlocResponse> getServiceCategory(GetServiceCategoryListEvent event);
  Future<BlocResponse> getCableConsultingData(
      GetCableConsultingDataEvent event);

  // Search Service Category
  Future<BlocResponse> searchServiceCategory(SearchServiceCategoryEvent event);

  /// Get Job ChatId
  Future<BlocResponse> jobChatId(GetJobChatIdEvent event);
}

class _JobsRepositoryImpl implements JobsRepository {
  final HttpServices _apiService = HttpServices();
  @override
  Future<BlocResponse> searchJobs(SearchJobEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.jobList,
        queryParams: {
          ApiKeys.searchKey: event.searchText,
          ApiKeys.pageNo: event.pageNo,
          ApiKeys.limit: maxJobInAPage,
          if (event.coordinates?.isNotEmpty ?? false)
            ApiKeys.coordinatesLongitude: event.coordinates![0],
          if (event.coordinates?.isNotEmpty ?? false)
            ApiKeys.coordinatesLatitude: event.coordinates![1],
        },
        body: {});
    return response;
  }

  @override
  Future<BlocResponse> jobDetails(GetJobDetailsEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.jobDetails,
        queryParams: {
          ApiKeys.jobId: event.jobId,
        },
        body: {});
    return response;
  }

  @override
  Future<BlocResponse> jobList(GetAllJobList event) async {
    BlocResponse response =
        await _apiService.apiRequest(ApiRequest.apiGet, event,
            apiEndPoint: ApiEndpoints.jobList,
            queryParams: {
              ApiKeys.pageNo: event.pageNo,
              ApiKeys.limit: maxJobInAPage,
              //If location is selected
              if (event.coordinates?.isNotEmpty ?? false)
                ApiKeys.coordinatesLongitude: event.coordinates![0],
              if (event.coordinates?.isNotEmpty ?? false)
                ApiKeys.coordinatesLatitude: event.coordinates![1],
            }..addAll(appliedFilters(event.filters)),
            body: {});
    return response;
  }

  @override
  Future<BlocResponse> getServiceCategory(
      GetServiceCategoryListEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.serviceCategoryList,
        queryParams: {ApiKeys.serviceType: event.type.enumValue.backendName},
        body: {});
    return response;
  }

  @override
  Future<BlocResponse> getCableConsultingData(
      GetCableConsultingDataEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.serviceCategoryList,
        queryParams: {
          ApiKeys.serviceType:
              ServiceTypeEnum.cableConsultingService.enumValue.backendName
        },
        body: {});
    return response;
  }

  @override
  Future<BlocResponse> searchServiceCategory(
      SearchServiceCategoryEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiGet, event,
        apiEndPoint: ApiEndpoints.serviceCategoryList,
        queryParams: {
          ApiKeys.searchKey: event.key,
          ApiKeys.serviceType: event.type.enumValue.backendName
        },
        body: {});
    return response;
  }

  @override
  Future<BlocResponse> jobChatId(GetJobChatIdEvent event) async {
    BlocResponse response = await _apiService.apiRequest(
        ApiRequest.apiPost, event,
        apiEndPoint: ApiEndpoints.getJobChatId,
        body: {ApiKeys.jobId: event.jobId});
    return response;
  }

  Map<String, dynamic> appliedFilters(FiltersModel? filters) {
    Map<String, dynamic> selectedFilters = {};
    if (_selectedJobPriorityFilter(filters)?.isNotEmpty ?? false) {
      selectedFilters
          .addAll({ApiKeys.priority: _selectedJobPriorityFilter(filters)});
    }
    if (_selectedJobStatusFilter(filters)?.isNotEmpty ?? false) {
      selectedFilters
          .addAll({ApiKeys.status: _selectedJobStatusFilter(filters)});
    }
    selectedFilters.addAll({ApiKeys.sortBy: "created"});
    if (filters?.selectedSortBy != null) {
      selectedFilters
          .addAll({ApiKeys.sortOrder: filters?.selectedSortBy?.backendEnum});
    }
    if (_selectedJobCategoryFilters(filters)?.isNotEmpty ?? false) {
      selectedFilters.addAll(
          {ApiKeys.serviceCategory: _selectedJobCategoryFilters(filters)});
    }
    return selectedFilters;
  }

  String? _selectedJobStatusFilter(FiltersModel? model) {
    if (model == null) {
      return null;
    }
    List<String> selectedEnum = model.status.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key.enumValue.backendName)
        .toList();
    if (selectedEnum.isEmpty) {
      return null;
    } else {
      return selectedEnum.join(',');
    }
  }

  String? _selectedJobCategoryFilters(FiltersModel? model) {
    if (model == null || model.selectedServiceCategory.isEmpty) {
      return null;
    }
    return model.selectedServiceCategory.join(',');
  }

  String? _selectedJobPriorityFilter(FiltersModel? model) {
    if (model == null) {
      return null;
    }
    List<String> selectedEnum = model.priority.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key.enumValue.backendName)
        .toList();
    if (selectedEnum.isEmpty) {
      return null;
    } else {
      return selectedEnum.join(',');
    }
  }

  ///clear data on logout
  @override
  Future<void> clearDataOnLogout() async {
    ctx.read<JobListingController>().add(ClearJobData());
    ctx.read<DynamicMapController>().add(ClearMapDataEvent());
  }
}
