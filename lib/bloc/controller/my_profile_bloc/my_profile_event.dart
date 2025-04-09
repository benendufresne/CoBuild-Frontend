import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/user_model/user_model.dart';

abstract class MyProfileEvent extends BlocEvent {
  const MyProfileEvent();
}

class MyProfileInitialEvent extends MyProfileEvent {
  const MyProfileInitialEvent();
}

///Update User Profile
class UpdateUserProfileEvent extends MyProfileEvent {
  UserModel model;
  UpdateUserProfileEvent({required this.model});
}

/// Update notification preference
class UpdateNotificationPreferenceEvent extends MyProfileEvent {
  UserModel model;
  UpdateNotificationPreferenceEvent({required this.model});
}
