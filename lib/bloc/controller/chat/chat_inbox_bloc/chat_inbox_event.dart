import 'package:cobuild/bloc/base/bloc_event.dart';

abstract class ChatInboxListEvent extends BlocEvent {}

class InitialChatInboxListEvent extends ChatInboxListEvent {}

class InitChatInboxPageEvent extends ChatInboxListEvent {
  InitChatInboxPageEvent();
}

class GetChatInboxListEvent extends ChatInboxListEvent {
  final bool isNextPage;
  final String? searchText;
  int pageNo;
  GetChatInboxListEvent(
      {this.isNextPage = false, this.searchText, this.pageNo = 1});
}

class UpdataInboxListDataEvent extends ChatInboxListEvent {
  final Map<String, dynamic> data;
  final int pageNo;
  UpdataInboxListDataEvent({required this.data, this.pageNo = 1});
}

class UpdateChatListingUiEvent extends ChatInboxListEvent {
  UpdateChatListingUiEvent();
}

class UpdateInboxReadStatus extends ChatInboxListEvent {
  final bool isUnRead;
  UpdateInboxReadStatus({this.isUnRead = false});
}

class ClearChatDataOnLogoutEvent extends ChatInboxListEvent {
  ClearChatDataOnLogoutEvent();
}
