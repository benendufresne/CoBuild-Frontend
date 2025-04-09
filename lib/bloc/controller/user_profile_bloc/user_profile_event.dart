import 'package:cobuild/bloc/base/bloc_event.dart';

/// Login
abstract class UserProfileEvent extends BlocEvent {
  const UserProfileEvent();
}

class UserProfileInitialEvent extends UserProfileEvent {
  UserProfileInitialEvent();
}

class UpdateUserProfileUIEvent extends UserProfileEvent {
  UpdateUserProfileUIEvent();
}
