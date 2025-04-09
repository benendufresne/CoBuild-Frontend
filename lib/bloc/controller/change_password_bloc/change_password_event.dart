import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/models/change_password_model/change_password_model.dart';

/// Change Password
abstract class ChangePasswordBaseEvent extends BlocEvent {
  const ChangePasswordBaseEvent();
}

class ChangePasswordInitialEvent extends ChangePasswordBaseEvent {
  ChangePasswordInitialEvent();
}

class ChangePasswordEvent extends ChangePasswordBaseEvent {
  final ChangePasswordModel model;
  const ChangePasswordEvent({required this.model});
}
