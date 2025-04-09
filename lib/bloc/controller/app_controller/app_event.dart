import 'package:cobuild/bloc/base/bloc_event.dart';

/// App Level Events
abstract class AppEvent extends BlocEvent {
  const AppEvent();
}

class AppInitialEvent extends AppEvent {
  AppInitialEvent();
}

class GetUserProfileEvent extends AppEvent {
  GetUserProfileEvent();
}

class GetStaticContentEvent extends AppEvent {
  GetStaticContentEvent();
}

class UpdateAllLocationSeenStatusLocallyEvent extends AppEvent {
  final bool seen;
  UpdateAllLocationSeenStatusLocallyEvent({this.seen = false});
}

class ClearAllGlobalDataEvent extends AppEvent {
  ClearAllGlobalDataEvent();
}

class LogoutEvent extends AppEvent {
  bool callApi;
  LogoutEvent({this.callApi = true});
}

class CheckAppVersionEvent extends AppEvent {
  const CheckAppVersionEvent();
}
