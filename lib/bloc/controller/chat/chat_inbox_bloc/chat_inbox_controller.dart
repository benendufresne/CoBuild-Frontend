import 'dart:async';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_event.dart';
import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_state.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_controller.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/chat/chat_inbox/chat_inbox_model.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/services/network_service.dart';
import 'package:cobuild/utils/services/socket/socket_service_handler.dart';
import 'package:cobuild/utils/silver_validation/silver_validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInboxController extends Bloc<ChatInboxListEvent, ChatInboxListState> {
  ValidatedController searchChatController = ValidatedController.notEmpty(
    validation: Validation.string.none(),
  );
  ChatInboxController()
      : super(ChatInboxListState(
            state: BlocState.none,
            event: InitialChatInboxListEvent(),
            response: null,
            stateStore: ChatInboxListStateStore())) {
    ///  Inbox Events
    on<InitChatInboxPageEvent>(_initChatInboxPage);
    on<GetChatInboxListEvent>(_getChatInboxList);
    on<UpdataInboxListDataEvent>(_updateInboxList);
    //
    on<UpdateChatListingUiEvent>(_updateUI);
    on<UpdateInboxReadStatus>(_updateInboxReadStatus);
    on<ClearChatDataOnLogoutEvent>(_deleteDataOnLogout);
  }

  //////////  ---------      Inobx list     --------- /////////
  // Get chat inbox list
  FutureOr<void> _initChatInboxPage(
      InitChatInboxPageEvent event, Emitter<ChatInboxListState> emit) {
    searchChatController.clear();
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _getChatInboxList(
    GetChatInboxListEvent event,
    Emitter<ChatInboxListState> emit,
  ) async {
    if (event.isNextPage && state.stateStore.list.nextHit < 1) {
      return;
    }
    emit(state.copyWith(state: BlocState.loading, event: event));
    if (event.isNextPage) {
      event.pageNo = state.stateStore.list.nextHit;
    }
    bool isInternet = await NetworkHelper.checkConnection();
    if (!isInternet) {
      showSnackBar(message: S.current.noInternet);
      emit(state.copyWith(state: BlocState.noInternet, event: event));
      return;
    }
    SocketHandlerService()
        .getInboxListing(searchText: event.searchText, pageNo: event.pageNo);
  }

  FutureOr<void> _updateInboxList(
      UpdataInboxListDataEvent event, Emitter<ChatInboxListState> emit) {
    if (event.data[ApiKeys.data] != null) {
      List<dynamic> list = event.data[ApiKeys.data];
      List<ChatInboxModel> requestList =
          list.map((e) => ChatInboxModel.fromJson(e)).toList();
      if (event.pageNo == 1) {
        state.stateStore.list.models = requestList;
      } else {
        state.stateStore.list.models.addAll(requestList);
      }
      state.stateStore.list.nextHit = event.data[ApiKeys.nextHit];
    }
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  /////////   ----------   Inbox List end      ----------  /////////

  FutureOr<void> _updateUI(
      UpdateChatListingUiEvent event, Emitter<ChatInboxListState> emit) {
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _updateInboxReadStatus(
      UpdateInboxReadStatus event, Emitter<ChatInboxListState> emit) {
    state.stateStore.isUnRead = event.isUnRead;
    emit(state.copyWith(state: BlocState.success, event: event));
  }

  FutureOr<void> _deleteDataOnLogout(
      ClearChatDataOnLogoutEvent event, Emitter<ChatInboxListState> emit) {
    state.stateStore.dispose();
    ctx.read<ChatPageController>().state.stateStore.dispose();
    emit(state.copyWith(state: BlocState.success, event: event));
  }
}
