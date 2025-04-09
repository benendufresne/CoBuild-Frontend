import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/services/network_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'network_state.dart';
part 'network_event.dart';

class NetworkController extends Bloc<NetworkEvent, NetworkState> {
  NetworkController._() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<CheckNetworkEvent>(_checkInternet);
    on<ResetNetworkState>(_resetNetwork);
  }

  static final NetworkController _instance = NetworkController._();

  factory NetworkController() => _instance;

  void _observe(event, emit) {
    NetworkHelper.observeNetwork();
  }

  Future<void> _checkInternet(
    CheckNetworkEvent event,
    Emitter<NetworkState> emit,
  ) async {
    emit(CheckNetworkLoading(isLoading: event.showLoading));
    await Future.delayed(KDuration.k200mls);
    final result = await NetworkHelper.checkConnection();
    if (result) {
      emit(CheckNetworkSuccess(event: event));
    } else {
      emit(CheckNetworkFailure(showMessage: event.showMessage));
    }
  }

  Future<void> _resetNetwork(
    ResetNetworkState event,
    Emitter<NetworkState> emit,
  ) async {
    emit(NetworkInitial());
  }
}
