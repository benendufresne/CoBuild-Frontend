import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/tutorial_bloc/tutorial_event.dart';
import 'package:cobuild/bloc/controller/tutorial_bloc/tutorial_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TutorialController extends Bloc<TutorialEvent, TutorialState> {
  TutorialController()
      : super(TutorialState(
          state: BlocState.none,
          event: const TutorialInitialEvent(),
          response: null,
        )) {
    on<ChangePageEvent>(_changePage);
  }

  ///change tutorial page
  _changePage(ChangePageEvent event, Emitter<TutorialState> emit) {
    emit(TutorialState(
        event: event,
        state: BlocState.success,
        response: BlocResponse(data: event.index)));
  }
}
