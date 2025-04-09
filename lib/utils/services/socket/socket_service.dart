import 'package:cobuild/bloc/repositories/global_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/models/user_model/user_model.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/services/socket/socket_service_handler.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

/// Class to handle socket connection
class AppSocketService {
  static final AppSocketService _singleton = AppSocketService._internal();

  factory AppSocketService() {
    return _singleton;
  }

  AppSocketService._internal();

  io.Socket? socket;
  UserModel? currentUser;

  bool isSocketActive() {
    printCustom(
        "socketService socket is active.. ${socket?.connected ?? false}");
    return socket?.connected ?? false;
  }

  Future<void> disconnectSocket() async {
    if (socket != null && socket?.connected == true) {
      socket?.disconnect();
      socket = null;
      io.cache.clear();
      printCustom('socketService manually disconnected');
      return;
    }
    printCustom('socketService already disconnected');
  }

  int i = 0;

  Future<void> initSocket({bool forceConnect = false}) async {
    printCustom("socketService trigger count ${i++}");
    UserModel? user = GlobalRepository().userModel;
    if (user != null) {
      currentUser = user;
    }

    if (!forceConnect) {
      if (socket != null && (socket?.connected ?? false)) {
        printCustom("socketService socket is already connected..");
        return;
      }
    }

    printCustom("socketService force connect $forceConnect");

    var token = AppPreferences().getUserToken();

    if (isBlank(token)) {
      printCustom("socketService token is null..");
      return;
    }

    // if (socket != null) {
    //   socket?.disconnect();
    //   socket = null;
    //   printCustom("socketService socket disconnected again");
    // }

    socket = io.io(
      SocketKeys.socketUrl + token,
      io.OptionBuilder()
          .setTransports([SocketKeys.socketType])
          .disableAutoConnect()
          .build(),
    );

    socket?.onConnectError((data) async {
      printCustom("socketService onConnectError $data");
      reconnect();
    });
    socket?.onConnect((data) {
      printCustom("socketService request sent to connect $data");
      SocketHandlerService().startSocketListener();
    });
    // Handle automatic reconnection
    socket?.onReconnectAttempt((attempt) {
      printCustom('socketService reconnection attempt: $attempt');
    });

    socket?.onReconnect((_) {
      printCustom('socketService reconnected');
    });

    socket?.onReconnectError((data) {
      printCustom('socketService reconnection error: $data');
    });

    socket?.onReconnectFailed((_) {
      printCustom('socketService reconnection failed');
    });
    socket?.onError((data) async {
      printCustom("socketService onError $data");
      reconnect();
    });
    socket?.connect();
  }

  Future<void> reconnect() async {
    currentUser = GlobalRepository().userModel;
    if (currentUser == null) return;
    socket?.auth = {'token': "Bearer ${AppPreferences().getUserToken()}"};
    printCustom('socketService reconnecting ${socket?.auth}');
    socket?.connect();
  }
}
