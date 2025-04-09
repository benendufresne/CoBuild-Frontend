import 'dart:async';
import 'package:cobuild/bloc/base/bloc_response.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/upload_media_bloc/upload_media_event.dart';
import 'package:cobuild/bloc/controller/upload_media_bloc/upload_media_state.dart';
import 'package:cobuild/bloc/repositories/upload_media_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadMediaController extends Bloc<UploadMediaEvents, UploadMediaState> {
  final UploadMediaRepository _repository = UploadMediaRepository();
  UploadMediaController()
      : super(UploadMediaState(
            state: BlocState.none,
            event: const UploadMediaInitialEvent(),
            response: null,
            store: UploadMediaStateStore())) {
    on<UploadMediaToServerEvent>(_getUrl);
  }

  FutureOr _getUrl(
      UploadMediaToServerEvent event, Emitter<UploadMediaState> emit) async {
    emit(state.copyWith(state: BlocState.loading, event: event));
    BlocResponse response = await _repository.uploadMedia(event);
    emit(state.copyWith(
        state: response.state ?? BlocState.failed, response: response));
  }
}
