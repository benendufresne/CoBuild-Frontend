import 'package:cobuild/bloc/base/bloc_event.dart';
import 'package:cobuild/utils/enums/app_enums.dart';

/// Events to handle app's Bottom navigation bar
abstract class BottomNavigationEvent extends BlocEvent {
  const BottomNavigationEvent();
}

class BottomNavigationInitialEvent extends BottomNavigationEvent {
  const BottomNavigationInitialEvent();
}

class ChangeSelectedTabEvent extends BottomNavigationEvent {
  final int? index;
  final BottomNavEnum? type;
  const ChangeSelectedTabEvent({this.type, this.index});
}
