import 'dart:io';
import 'package:cobuild/bloc/controller/network_bloc/network_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper {
  static void observeNetwork() async {
    final res = await checkConnection();
    if (!res) {
      NetworkController().add(NetworkNotify());
    }
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult?> result) async {
      final result = await checkConnection();
      if (result) {
        NetworkController().add(NetworkNotify(isConnected: true));
      } else {
        NetworkController().add(NetworkNotify());
      }
    });
  }

  /// Returns true if has internet. Else false.
  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
