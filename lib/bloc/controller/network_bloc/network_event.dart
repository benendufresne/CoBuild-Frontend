part of 'network_bloc.dart';

abstract class NetworkEvent {}

class NetworkObserve extends NetworkEvent {}

class CheckNetworkEvent extends NetworkEvent {
  final bool showLoading;
  final bool showMessage;
  CheckNetworkEvent({this.showLoading = false, this.showMessage = false});
}

class ResetNetworkState extends NetworkEvent {
  ResetNetworkState();
}

class NetworkNotify extends NetworkEvent {
  final bool isConnected;

  NetworkNotify({this.isConnected = false});
}
