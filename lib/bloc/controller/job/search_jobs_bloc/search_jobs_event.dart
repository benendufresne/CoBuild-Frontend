import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class SearchJobBaseEvent extends BlocEvent {
  const SearchJobBaseEvent();
}

class SearchJobInitialEvent extends SearchJobBaseEvent {
  const SearchJobInitialEvent();
}

/// Search Jobs Listing
class SearchJobEvent extends SearchJobBaseEvent {
  String searchText;
  final bool isNextPage;
  int pageNo;
  List<double>? coordinates;
  SearchJobEvent(
      {required this.searchText,
      this.isNextPage = false,
      this.pageNo = 1,
      this.coordinates});
}
