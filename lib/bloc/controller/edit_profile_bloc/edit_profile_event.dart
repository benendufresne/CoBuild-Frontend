import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/user_model/user_model.dart';

/// Edit User Profile
abstract class EditProfileBaseEvent extends BlocEvent {
  const EditProfileBaseEvent();
}

class EditProfileInitialEvent extends EditProfileBaseEvent {
  EditProfileInitialEvent();
}

class EditProfileEvent extends EditProfileBaseEvent {
  final UserModel model;
  const EditProfileEvent({required this.model});
}
