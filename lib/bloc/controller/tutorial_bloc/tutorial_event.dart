import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class TutorialEvent extends BlocEvent {
  const TutorialEvent();
}

class TutorialInitialEvent extends TutorialEvent {
  const TutorialInitialEvent();
}

///change tutorial page
class ChangePageEvent extends TutorialEvent {
  int index;
  ChangePageEvent({required this.index});
}
