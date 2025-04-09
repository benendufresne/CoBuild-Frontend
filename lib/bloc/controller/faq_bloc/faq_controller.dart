import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/faq_bloc/faq_events.dart';
import 'package:cobuild/bloc/controller/faq_bloc/faq_states.dart';
import 'package:cobuild/bloc/repositories/my_profile_repo.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FAQController extends Bloc<FAQEvent, FAQState> {
  final MyProfileRepository _repository = MyProfileRepository();

  /// Delete Account
  final FocusNode deleteAccountPasswordFocus = FocusNode();
  ValidatedController deleteAccountPasswordController =
      ValidatedController.notEmpty(
    validation: Validation.string.password(),
  );
  FAQController()
      : super(FAQState(
            state: BlocState.none,
            event: const FAQInitialEvent(),
            response: null,
            store: FAQStateStore())) {
    on<GetFAQsEvent>(_getFAQ);
  }

  /// Get FAQ
  _getFAQ(GetFAQsEvent event, Emitter<FAQState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.getFAQs(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }
}
