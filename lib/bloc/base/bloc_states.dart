import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_response.dart';

enum BlocState {
  none,
  loading,
  noInternet,
  success,
  failed;

  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isFailed => this == failed;
  bool get isNoInternet => this == noInternet;
}

class BlocEventState<T> {
  BlocState state;
  BlocEvent? event;
  BlocResponse? response;
  T? data;

  BlocEventState({
    required this.state,
    this.response,
    this.event,
    this.data,
  });

  BlocEventState copyWith() => BlocEventState(state: state);
}
