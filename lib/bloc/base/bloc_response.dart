import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';

class BlocResponse<T> {
  final BlocState? state;
  final BlocEvent? event;
  final T? data;
  final T? dataNew;
  final String? message;
  final int? statusCode;
  final Type? exceptionType;
  BlocState? prevState;
  BlocEvent? prevEvent;

  BlocResponse({
    this.state,
    this.event,
    this.data,
    this.dataNew,
    this.message,
    this.statusCode,
    this.exceptionType,
    this.prevState,
    this.prevEvent,
  });

  BlocResponse copyWith({
    BlocState? state,
    BlocEvent? event,
    T? data,
    T? dataNew,
    String? message,
    int? statusCode,
    Type? exceptionType,
    BlocState? prevState,
    BlocEvent? prevEvent,
  }) =>
      BlocResponse(
        state: state ?? this.state,
        event: event ?? this.event,
        data: data ?? this.data,
        dataNew: dataNew ?? this.dataNew,
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
        exceptionType: exceptionType ?? this.exceptionType,
        prevState: prevState ?? this.prevState,
        prevEvent: prevEvent ?? this.prevEvent,
      );
}
