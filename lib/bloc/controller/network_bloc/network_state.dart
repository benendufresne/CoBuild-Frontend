part of 'network_bloc.dart';

abstract class NetworkState {}

class NetworkInitial extends NetworkState {}

class NetworkSuccess extends NetworkState {}

class NetworkFailure extends NetworkState {}

class CheckNetworkLoading extends NetworkState {
  final bool isLoading;
  CheckNetworkLoading({this.isLoading = false});
}

class CheckNetworkSuccess extends NetworkState {
  final NetworkEvent? event;
  CheckNetworkSuccess({this.event});
}

class CheckNetworkFailure extends NetworkState {
  final bool showMessage;
  CheckNetworkFailure({this.showMessage = false});
}
