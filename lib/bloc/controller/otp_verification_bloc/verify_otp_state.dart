import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:flutter/material.dart';

class VerifyOtpState extends BlocEventState {
  VerifyOtpState(
      {super.response,
      super.event,
      super.state = BlocState.none,
      required this.otpController});
  TextEditingController otpController;
  @override
  VerifyOtpState copyWith({
    BlocState? state,
    BlocEvent? event,
    BlocResponse<dynamic>? response,
  }) =>
      VerifyOtpState(
          state: state ?? BlocState.none,
          event: event,
          response: response,
          otpController: otpController);
}
