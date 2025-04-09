import 'dart:async';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/change_password_bloc/change_password_event.dart';
import 'package:cobuild/bloc/controller/change_password_bloc/change_password_state.dart';
import 'package:cobuild/bloc/repositories/my_profile_repo.dart';
import 'package:cobuild/models/change_password_model/change_password_model.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordController
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final MyProfileRepository _repository = MyProfileRepository();

  /// Change Password
  final FocusNode oldPasswordFocus = FocusNode();
  final FocusNode newPasswordFocus = FocusNode();
  final FocusNode confirmNewPasswordFocus = FocusNode();
  final ValidatedController<PasswordValidation> oldPasswordController =
      ValidatedController.notEmpty(
    validation: Validation.string.password(),
  );
  final ValidatedController<PasswordValidation> newPasswordController =
      ValidatedController.notEmpty(
    validation: Validation.string.password(),
  );
  late final ValidatedController confirmNewPasswordController =
      RepeatPasswordValidatedController.notEmpty(
    mainPasswordController: newPasswordController,
  );

  ChangePasswordController()
      : super(ChangePasswordState(
            state: BlocState.none,
            event: ChangePasswordInitialEvent(),
            response: null,
            stateStore: ChangePasswordStateStore())) {
    on<ChangePasswordEvent>(_changePassword);
  }

  /// Change Password
  FutureOr<void> _changePassword(
    ChangePasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.changePassword(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }

  /// Get Model
  ChangePasswordModel getModel() {
    return ChangePasswordModel(
        oldPassword: oldPasswordController.value.trim(),
        password: newPasswordController.text.trim(),
        confirmPassword: confirmNewPasswordController.text.trim());
  }

  /// Clear inputFields
  void clearChangePasswordFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();
  }

  @override
  Future<void> close() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    return super.close();
  }
}
