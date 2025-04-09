import 'dart:async';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/edit_profile_bloc/edit_profile_event.dart';
import 'package:cobuild/bloc/controller/edit_profile_bloc/edit_profile_state.dart';
import 'package:cobuild/bloc/repositories/my_profile_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/models/user_model/user_model.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileController
    extends Bloc<EditProfileBaseEvent, EditProfileState> {
  final MyProfileRepository _repository = MyProfileRepository();

  /// Change Password
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();

  CountryCode countrycode = defaultCountryCode;
  bool enableEmailField = true;

  ValidatedController nameController = ValidatedController.notEmpty(
    validation: Validation.string.name(),
  );
  ValidatedController addressController = ValidatedController.notEmpty(
    validation: Validation.string.addrress(),
  );
  ValidatedController phoneController = ValidatedController.notEmpty(
    validation: Validation.string.phone(),
  );
  ValidatedController emailController = ValidatedController.notEmpty(
    validation: Validation.string.email(),
  );
  LocationModel? addressModel = LocationModel();

  EditProfileController()
      : super(EditProfileState(
            state: BlocState.none,
            event: EditProfileInitialEvent(),
            response: null,
            stateStore: EditProfileStateStore())) {
    on<EditProfileEvent>(_editProfile);
  }

  /// Init Event
  FutureOr<void> initData() async {
    nameController.text = AppPreferences.name;
    emailController.text = AppPreferences.email;
    if (emailController.text.isNotEmpty) {
      enableEmailField = false;
    }
    phoneController.text = AppPreferences.phone;
    addressController.text = AppPreferences.address;
    addressModel = LocationModel(
        address: AppPreferences.address,
        coordinates: [AppPreferences.longitude, AppPreferences.latitude]);
  }

  /// Edit Profile
  FutureOr<void> _editProfile(
    EditProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.editProfile(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  /// Get Model
  UserModel getModel() {
    UserModel model = UserModel();
    if (nameController.text.isNotEmpty) {
      model.name = nameController.text.trim();
    }
    if (phoneController.text.isNotEmpty) {
      model.mobileNo = phoneController.text.trim();
    }
    if (addressController.text.isNotEmpty) {
      model.location = addressModel;
    }
    return model;
  }

  /// Clear inputFields
  void clearChangePasswordFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    return super.close();
  }
}
