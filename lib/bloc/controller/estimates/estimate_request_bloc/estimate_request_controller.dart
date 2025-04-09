import 'dart:async';
import 'dart:io';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_controller.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_event.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_event.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_state.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_event.dart';
import 'package:cobuild/bloc/controller/upload_media_bloc/upload_media_event.dart';
import 'package:cobuild/bloc/repositories/estimate_repo.dart';
import 'package:cobuild/bloc/repositories/jobs_repo.dart';
import 'package:cobuild/bloc/repositories/upload_media_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/estimates/cable_consulting_data/cable_consulting_model/cable_consulting_model.dart';
import 'package:cobuild/models/estimates/cable_consulting_data/cable_consulting_sub_model/cable_consulting_sub_model.dart';
import 'package:cobuild/models/estimates/cable_consulting_data/top_level_cable_consulting_model/top_level_cable_consulting_model.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/models/service_category/service_category.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/enums/estimates_enum.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// For Creating Request
class EstimateRequestController
    extends Bloc<EstimateRequestEvent, EstimateRequestState> {
  final EstimateRepository _repository = EstimateRepository();

  // Service Category
  final FocusNode serviceCategoryFocus = FocusNode();
  ValidatedController serviceCategoryController = ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );
  ServiceTypeEnum? selectedServiceType;

  // Service Category :-
  // i.Category Service
  // ii.Custom Service
  // iii.Cable Consulting Service

  /// Sub categories -------- ///
  // i.Select Category :- if Service is "Category Service"
  final FocusNode categoryServiceFocus = FocusNode();
  ValidatedController categoryServiceController = ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );
  ServiceCategoryModel? selectedServiceCategory;

  // ii.Select Category :- if Service is "Custom Service"
  final FocusNode customServiceFocus = FocusNode();
  ValidatedController customServiceController = ValidatedController.notEmpty(
    validation: Validation.string.customServiceName(),
  );

  // iii.Select Category :- if Service is "Cable consulting Service"
  final FocusNode consultingServiceFocus = FocusNode();
  ValidatedController consultingIssueController = ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );
  final FocusNode consultingSubIssueFocus = FocusNode();
  ValidatedController consultingSubIssueController =
      ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );
  TopLevelCableConsultingIssueModel? selectedCableConsultingIssueType;
  CableConsultingSubCategoryModel? selectedCableConsultingSubIssueType;
  String? cableConsultingIssueName;

  /// -------- ///

  // Address
  final FocusNode addressFocus = FocusNode();
  ValidatedController addressController = ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );
  LocationModel locationModel = LocationModel();

  // Full name
  final FocusNode fullNameFocus = FocusNode();
  ValidatedController fullNameController = ValidatedController.notEmpty(
    validation: Validation.string.name(),
  );

  // Mobile
  final FocusNode mobileNumberFocus = FocusNode();
  CountryCode countrycode = defaultCountryCode;
  ValidatedController mobileNumberController = ValidatedController.notEmpty(
    validation: Validation.string.phone(),
  );

  // Description
  final FocusNode descriptionFocus = FocusNode();
  ValidatedController descriptionController = ValidatedController.notEmpty(
    validation: Validation.string.text(),
  );

  // Selected Media
  File? selectedMedia;
  // Used In case of edit estimate request
  MediaModel? uploadedMediaModel;

  EstimateRequestController()
      : super(EstimateRequestState(
            state: BlocState.none,
            event: const EstimateRequestInitialEvent(),
            response: null)) {
    on<CreateEstimateRequestEvent>(_createEstimateRequest);
    on<UpdateEstimateRequestEvent>(_updateEstimateRequest);
    on<SelectServiceTypeInCreateRequestEvent>(_selectServiceType);
    on<SelectCableConsultingIssueInCreateRequestEvent>(
        _selectCableConsultingIssue);
    on<SelectCableConsultingsubIssueInCreateRequestEvent>(
        _selectCableConsultingSubIssue);
    on<SelectServiceCategoryCreateRequestEvent>(_selectServiceCategory);
    on<InitDataInCreateRequestEvent>(_initAllData);
    on<SelectMediaInCreateRequestEvent>(_selectMedia);
  }

  /// Create Estimate Request
  FutureOr _createEstimateRequest(CreateEstimateRequestEvent event,
      Emitter<EstimateRequestState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    if (selectedMedia != null) {
      UploadMediaRepository mediaRepository = UploadMediaRepository();
      UploadMediaToServerEvent uploadMediaEvent =
          UploadMediaToServerEvent(file: selectedMedia!);
      BlocResponse mediaResponse =
          await mediaRepository.uploadMedia(uploadMediaEvent);
      if (mediaResponse.state == BlocState.success) {
        event.model.media = uploadMediaEvent.fileName;
        event.model.mediaType = uploadMediaEvent.fileType;
      } else {
        emit(state.copyWith(state: BlocState.failed, event: event));
      }
    }
    BlocResponse response = await _repository.createEstimateRequest(event);
    if (response.state == BlocState.success && response.data != null) {
      EstimateRequestModel model =
          EstimateRequestModel.fromJson(response.data[ApiKeys.data]);
      if (ctx.mounted) {
        ctx
            .read<ActiveEstimateController>()
            .add(AddCreatedEstimatesEvent(model: model));
      }
      emit(state.copyWith(
          state: BlocState.success,
          response: BlocResponse(data: model),
          event: event));
    } else {
      emit(state.copyWith(
          state: response.state ?? BlocState.failed,
          response: response,
          event: event));
    }
  }

  FutureOr _updateEstimateRequest(UpdateEstimateRequestEvent event,
      Emitter<EstimateRequestState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    if (selectedMedia != null) {
      UploadMediaRepository mediaRepository = UploadMediaRepository();
      UploadMediaToServerEvent uploadMediaEvent =
          UploadMediaToServerEvent(file: selectedMedia!);
      BlocResponse mediaResponse =
          await mediaRepository.uploadMedia(uploadMediaEvent);
      if (mediaResponse.state == BlocState.success) {
        event.model.media = uploadMediaEvent.fileName;
        event.model.mediaType = uploadMediaEvent.fileType;
      } else {
        emit(state.copyWith(state: BlocState.failed, event: event));
      }
    } else if (uploadedMediaModel != null) {
      event.model.media = uploadedMediaModel?.media;
      event.model.mediaType = uploadedMediaModel?.mediaType;
    }
    BlocResponse response = await _repository.updateEstimateRequest(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed,
        response: response,
        event: event));
  }

  FutureOr _selectServiceType(SelectServiceTypeInCreateRequestEvent event,
      Emitter<EstimateRequestState> emit) async {
    if (event.type == selectedServiceType) {
      return;
    }
    _clearThreeServiceData();
    selectedServiceType = event.type;
    serviceCategoryController.text = event.type.enumValue.displayName;
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  /// If Category service is selected
  FutureOr _selectServiceCategory(SelectServiceCategoryCreateRequestEvent event,
      Emitter<EstimateRequestState> emit) async {
    _setCategoryService(event.type);
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  void _setCategoryService(ServiceCategoryModel type) {
    selectedServiceCategory = type;
    categoryServiceController.text = type.categoryName ?? '';
  }

  /// Cable consulting
  FutureOr _selectCableConsultingIssue(
      SelectCableConsultingIssueInCreateRequestEvent event,
      Emitter<EstimateRequestState> emit) async {
    if (event.type.categoryName ==
        selectedCableConsultingIssueType?.categoryName) {
      return;
    }
    _setCableConsultingIssueType(event.type);
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  void _setCableConsultingIssueType(TopLevelCableConsultingIssueModel type) {
    _clearCableConsultingSubCategoryData();
    selectedCableConsultingIssueType = type;
    consultingIssueController.text = type.categoryName;
  }

  FutureOr _selectCableConsultingSubIssue(
      SelectCableConsultingsubIssueInCreateRequestEvent event,
      Emitter<EstimateRequestState> emit) async {
    _setCableConsultingSubIssue(event.type, event.name);
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  void _setCableConsultingSubIssue(
      CableConsultingSubCategoryModel? type, String? name) {
    selectedCableConsultingSubIssueType = type;
    if (name?.trim().isNotEmpty ?? false) {
      consultingSubIssueController.text = name ?? '';
      cableConsultingIssueName = name;
    } else {
      consultingSubIssueController.text = type?.issueTypeName ?? '';
      cableConsultingIssueName = null;
    }
  }

  void _clearCableConsultingData() {
    selectedCableConsultingIssueType = null;
    consultingIssueController.text = '';
    _clearCableConsultingSubCategoryData();
  }

  void _clearCableConsultingSubCategoryData() {
    selectedCableConsultingSubIssueType = null;
    consultingSubIssueController.text = '';
    cableConsultingIssueName = null;
  }

  /// End

  _clearCustomServiceData() {
    customServiceController.text = '';
  }

  _clearCategoryServiceData() {
    selectedServiceCategory = null;
    categoryServiceController.text = '';
  }

  _clearThreeServiceData() {
    _clearCategoryServiceData();
    _clearCustomServiceData();
    _clearCableConsultingData();
  }

  FutureOr _initAllData(InitDataInCreateRequestEvent event,
      Emitter<EstimateRequestState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));

    /// Clear all data
    // Clear main service type
    selectedServiceType = null;
    serviceCategoryController.text = '';
    _clearThreeServiceData();
    addressController.text = '';
    fullNameController.text = '';
    mobileNumberController.text = '';
    descriptionController.text = '';
    selectedMedia = null;
    locationModel = LocationModel();
    uploadedMediaModel = null;

    /// Init Data
    if (event.model != null) {
      // Set main service type
      selectedServiceType =
          getServiceTypeEnumFromBackendValue(event.model?.serviceType ?? '');
      serviceCategoryController.text =
          selectedServiceType?.enumValue.displayName ?? '';

      /// Set sub type data
      if (selectedServiceType == ServiceTypeEnum.categoryService) {
        _setCategoryService(ServiceCategoryModel(
          sid: event.model?.categoryId ?? '',
          categoryIdString: event.model?.categoryIdString ?? '',
          categoryName: event.model?.categoryName ?? '',
        ));
      } else if (selectedServiceType == ServiceTypeEnum.customService) {
        customServiceController.text = event.model?.categoryName ?? '';
      } else if (selectedServiceType ==
          ServiceTypeEnum.cableConsultingService) {
        BlocResponse blocResponse = await JobsRepository()
            .getCableConsultingData(const GetCableConsultingDataEvent());
        if (blocResponse.state == BlocState.success) {
          CableConsultingModel cableConsultingModel =
              CableConsultingModel.fromJson(blocResponse.data);
          int index = cableConsultingModel.data
              .indexWhere((e) => e.categoryName == event.model?.categoryName);
          if (index >= 0) {
            // Cable Consulting issue type
            _setCableConsultingIssueType(cableConsultingModel.data[index]);
            // Cable Consulting issue type
            _setCableConsultingSubIssue(
                CableConsultingSubCategoryModel(
                    issueTypeName: event.model?.issueTypeName ?? ''),
                event.model?.subIssueName);
          }
        } else {
          emit(state.copyWith(state: blocResponse.state, event: event));
          return;
        }
      }
      // Set common data
      fullNameController.text = event.model?.name ?? '';
      descriptionController.text = event.model?.description ?? '';
      // Set location
      addressController.text = event.model?.location?.address ?? '';
      locationModel = event.model?.location ?? LocationModel();

      // Set media data
      uploadedMediaModel = MediaModel(
          media: event.model?.media, mediaType: event.model?.mediaType);
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr _selectMedia(SelectMediaInCreateRequestEvent event,
      Emitter<EstimateRequestState> emit) async {
    if (event.file != null) {
      selectedMedia = File(event.file!.path);
      uploadedMediaModel = null;
    } else {
      selectedMedia = null;
      uploadedMediaModel = null;
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  EstimateRequestModel get getCreateModel {
    EstimateRequestModel model = EstimateRequestModel(
      serviceType: selectedServiceType?.enumValue.backendName,
      name: fullNameController.text.trim(),
      location: LocationModel(
          coordinates: locationModel.coordinates,
          address: locationModel.address),
      description: descriptionController.text.trim(),
    );
    if (selectedServiceType == ServiceTypeEnum.categoryService) {
      model.categoryName = selectedServiceCategory?.categoryName;
      model.categoryId = selectedServiceCategory?.sid;
      model.categoryIdString = selectedServiceCategory?.categoryIdString;
    } else if (selectedServiceType == ServiceTypeEnum.customService) {
      model.categoryName = customServiceController.text.trim();
    } else if (selectedServiceType == ServiceTypeEnum.cableConsultingService) {
      model.categoryName = selectedCableConsultingIssueType?.categoryName;
      model.issueTypeName = selectedCableConsultingSubIssueType?.issueTypeName;
      if (cableConsultingIssueName?.trim().isNotEmpty ?? false) {
        model.subIssueName = cableConsultingIssueName;
      } else {
        model.subIssueName = ' ';
      }
    }
    return model;
  }

  bool isAllDetailsFilled() {
    if ((locationModel.address?.isNotEmpty ?? false) &&
        (fullNameController.text.trim().isNotEmpty) &&
        (descriptionController.text.trim().isNotEmpty)) {
      switch (selectedServiceType) {
        case ServiceTypeEnum.categoryService:
          return selectedServiceCategory != null;
        case ServiceTypeEnum.customService:
          return customServiceController.text.trim().isNotEmpty;
        case ServiceTypeEnum.cableConsultingService:
          return selectedCableConsultingIssueType != null;
        default:
          return false;
      }
    } else {
      return false;
    }
  }
}
