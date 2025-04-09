import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class FAQEvent extends BlocEvent {
  const FAQEvent();
}

class FAQInitialEvent extends FAQEvent {
  const FAQInitialEvent();
}

/// Get FAQ
class GetFAQsEvent extends FAQEvent {
  const GetFAQsEvent();
}
