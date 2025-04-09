import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/otp_verification_bloc/verify_otp_event.dart';
import 'package:cobuild/bloc/controller/otp_verification_bloc/verify_otp_state.dart';
import 'package:cobuild/bloc/repositories/onboarding_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyOtpController extends Bloc<OtpEvent, VerifyOtpState> {
  final OnboardingRepository _repository = OnboardingRepository();
  VerifyOtpController()
      : super(VerifyOtpState(
            state: BlocState.none,
            event: OtpInitialEvent(),
            response: null,
            otpController: TextEditingController())) {
    /// Singup
    on<VerifyOtpEvent>(_verifySignupEmailOtp);
    on<ResendOtpEvent>(_resendSignupOtpOnEmail);
  }

  /// Verify OTP :-
  Future<void> _verifySignupEmailOtp(
      VerifyOtpEvent event, Emitter<VerifyOtpState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.verifySignupEmailOtp(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed,
        event: event,
        response: response));
  }

  Future<void> _resendSignupOtpOnEmail(
      ResendOtpEvent event, Emitter<VerifyOtpState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.resendSignupEmailOtp(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed,
        event: event,
        response: response));
  }

  void clearOtpField() {
    state.otpController.clear();
  }

  @override
  Future<void> close() {
    state.otpController.dispose();
    return super.close();
  }
}
