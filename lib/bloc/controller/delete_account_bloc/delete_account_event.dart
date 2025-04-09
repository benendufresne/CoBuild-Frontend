import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class DeleteAccountBaseEvent extends BlocEvent {
  const DeleteAccountBaseEvent();
}

class DeleteAccountInitialEvent extends DeleteAccountBaseEvent {
  const DeleteAccountInitialEvent();
}

///change tutorial
class DeleteAccountEvent extends DeleteAccountBaseEvent {
  String password;
  DeleteAccountEvent({required this.password});
}
