import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/network_bloc/network_bloc.dart';
import 'package:cobuild/global/printing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocBuilderNew<T extends StateStreamable<X>, X extends BlocEventState>
    extends StatelessWidget {
  //widgets for different state
  final Widget Function(X) defaultView;
  final Widget? Function(X)? loadingView;
  final Widget Function(X)? noInternetView;
  final Widget Function(X)? successView;
  final Widget Function(X)? failedView;

  //callbacks for different state
  final void Function(X)? onSuccess;
  final void Function(X)? onFailed;
  final void Function(X)? onNoInternet;
  final void Function(X)? onLoading;

  //callbacks for managing builder/listener
  final bool Function(X oldState, X newState)? buildWhen;
  final bool Function(X oldState, X newState)? listenWhen;

  // final T controller;

  const BlocBuilderNew({
    super.key,
    required this.defaultView,
    this.loadingView,
    this.noInternetView,
    this.successView,
    this.failedView,
    this.onFailed,
    this.onSuccess,
    this.onLoading,
    this.onNoInternet,
    this.buildWhen,
    this.listenWhen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<T, X>(
      buildWhen: buildWhen,
      listenWhen: listenWhen,
      builder: (context, state) {
        printLocal(
            'New update state ${state.state}  & event ${state.event} & message is ${state.response?.message}');
        switch (state.state) {
          case BlocState.loading:
            return (loadingView == null)
                ? defaultView(state)
                : loadingView!(state) ?? defaultView(state);
          case BlocState.noInternet:
            return (noInternetView == null)
                ? defaultView(state)
                : noInternetView!(state);
          case BlocState.success:
            return (successView == null)
                ? defaultView(state)
                : successView!(state);
          case BlocState.failed:
            return (failedView == null)
                ? defaultView(state)
                : failedView!(state);
          default:
            return defaultView(state);
        }
      },
      listener: (context, state) async {
        if (state.state.isSuccess) {
          context.read<NetworkController>().add(ResetNetworkState());
        }
        _callback(state);
      },
    );
  }

  Future<void> _callback(X state) async {
    if (state.state == state.response?.prevState &&
        state.event == state.response?.prevEvent) {
      printLocal('same state previous');
      return;
    }
    switch (state.state) {
      case BlocState.failed:
        if (onFailed != null) onFailed!(state);
        break;
      case BlocState.success:
        if (onSuccess != null) onSuccess!(state);
        break;
      case BlocState.loading:
        if (onLoading != null) onLoading!(state);
        break;
      case BlocState.noInternet:
        if (onNoInternet != null) onNoInternet!(state);
        break;
      default:
    }
  }
}
