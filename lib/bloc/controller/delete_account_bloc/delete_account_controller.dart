import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/delete_account_bloc/delete_account_event.dart';
import 'package:cobuild/bloc/controller/delete_account_bloc/delete_state.dart';
import 'package:cobuild/bloc/repositories/my_profile_repo.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountController
    extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final MyProfileRepository _repository = MyProfileRepository();

  /// Delete Account
  final FocusNode deleteAccountPasswordFocus = FocusNode();
  ValidatedController deleteAccountPasswordController =
      ValidatedController.notEmpty(
    validation: Validation.string.password(),
  );
  DeleteAccountController()
      : super(DeleteAccountState(
          state: BlocState.none,
          event: const DeleteAccountInitialEvent(),
          response: null,
        )) {
    on<DeleteAccountEvent>(_deleteAccount);
  }

  /// Delete Account
  Future<void> _deleteAccount(
      DeleteAccountEvent event, Emitter<DeleteAccountState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.deleteAccount(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }
}
