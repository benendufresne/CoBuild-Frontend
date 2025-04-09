import 'dart:async';
import 'dart:io';

import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/report_damage/add_damage_report/add_damage_report_event.dart';
import 'package:cobuild/bloc/controller/report_damage/add_damage_report/add_damage_report_state.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_data/damage_report_controller.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_data/damage_report_event.dart';
import 'package:cobuild/bloc/controller/upload_media_bloc/upload_media_event.dart';
import 'package:cobuild/bloc/repositories/damage_report_repo.dart';
import 'package:cobuild/bloc/repositories/upload_media_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/models/report_damage/damange_model/damage_model.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDamageController extends Bloc<AddDamageEvent, AddDamageState> {
  final DamageReportRepository _repository = DamageReportRepository();
  UploadMediaRepository mediaRepository = UploadMediaRepository();

  /// Type of damage
  final FocusNode typeOfDamageFocus = FocusNode();
  ValidatedController typeOfDamageController = ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );

  /// Descrption
  final FocusNode descriptionFocus = FocusNode();
  ValidatedController descriptionController = ValidatedController.notEmpty(
    validation: Validation.string.text(),
  );

  // Address
  final FocusNode addressFocus = FocusNode();
  ValidatedController addressController = ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );
  LocationModel locationModel = LocationModel();

  // Media
  List<File>? selectedMedia = [];

  AddDamageController()
      : super(AddDamageState(
            state: BlocState.none,
            event: const AddDamageInitialEvent(),
            response: null,
            store: AddDamageStateStore())) {
    on<AddDamageReportEvent>(_addDamageReport);
    on<AddMediaInDamageReportEvent>(_selectMedia);
  }

  /// Add Damage Report
  FutureOr _addDamageReport(
      AddDamageReportEvent event, Emitter<AddDamageState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    if (selectedMedia?.isNotEmpty ?? false) {
      List<MediaModel> uploadedMedia = await uploadImages(selectedMedia ?? []);
      if (uploadedMedia.length != selectedMedia?.length) {
        showSnackBar(message: S.current.somethingWentWrong);
        emit(state.copyWith(state: BlocState.failed, event: event));
      } else {
        event.model.media = uploadedMedia;
      }
    }
    BlocResponse response = await _repository.addDamageReport(event);
    if (response.state == BlocState.success && response.data != null) {
      DamageModel model = DamageModel.fromJson(response.data[ApiKeys.data]);
      if (ctx.mounted) {
        ctx
            .read<DamageReportListingController>()
            .add(AddReportDamageEvent(model: model));
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

  Future<List<MediaModel>> uploadImages(List<File> selectedMedia) async {
    List<MediaModel> uploadedMedia = [];
    if (selectedMedia.isNotEmpty) {
      for (var media in selectedMedia) {
        UploadMediaToServerEvent uploadMediaEvent =
            UploadMediaToServerEvent(file: media);
        BlocResponse mediaResponse =
            await mediaRepository.uploadMedia(uploadMediaEvent);
        if (mediaResponse.state == BlocState.success) {
          uploadedMedia.add(MediaModel(
              media: uploadMediaEvent.fileName,
              mediaType: uploadMediaEvent.fileType));
        }
      }
    }
    return uploadedMedia;
  }

  FutureOr _selectMedia(
      AddMediaInDamageReportEvent event, Emitter<AddDamageState> emit) async {
    if (event.files?.isNotEmpty ?? false) {
      selectedMedia = event.files;
    } else {
      selectedMedia = [];
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  DamageModel get getCreateModel {
    return DamageModel(
      type: typeOfDamageController.text.trim(),
      description: descriptionController.text.trim(),
      location: locationModel,
    );
  }

  bool get isAllDetailsFilled {
    if ((typeOfDamageController.text.trim().isNotEmpty) &&
        (descriptionController.text.trim().isNotEmpty) &&
        (locationModel.address?.isNotEmpty ?? false)) {
      return true;
    } else {
      return false;
    }
  }
}
