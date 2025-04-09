import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_controller.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_event.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/chat/chat_detail_page/chat_card.dart';
import 'package:cobuild/ui/chat/components/chat_profile_image.dart';
import 'package:cobuild/ui/chat/chat_detail_page/message_text_field.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/shimmer_files/chat/chat_page_messages_shimmer.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/debouncer.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Chat page :- where user can read previous messages and exchange messages.
class ChatPage extends StatefulWidget {
  final String id;
  const ChatPage({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatPageController controller;
  late ScrollController scrollController;
  late ChatPageStateStore store;
  late String roomId;
  final DeBouncer debouncer = DeBouncer(milliseconds: 300);
  @override
  void initState() {
    super.initState();
    controller = context.read<ChatPageController>();
    store = controller.state.stateStore;
    roomId = widget.id;
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    _enterInChatRoom();
  }

  void _enterInChatRoom() {
    controller.add(EnterChatRoomEvent(id: roomId));
  }

  void _onScroll() {
    if ((scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) &&
        !(controller.state.event is GetMessagesListEvent &&
            controller.state.state == BlocState.loading)) {
      // Fetch the next page messages
      debouncer.run(() {
        controller
            .add(GetMessagesListEvent(isNextPage: true, chatRoomId: roomId));
      });
    }
  }

  @override
  void dispose() {
    _callRoomLeftEvent();
    super.dispose();
  }

  void _callRoomLeftEvent() {
    controller.add(ExitChatRoomEvent(id: roomId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilderNew<ChatPageController, ChatPageState>(
        defaultView: (blocState) {
      return Scaffold(
          appBar: CommonAppBar.appBar(
              title: store.chatRoomModel?.name ?? '',
              titleIcon: const ChatProfileImage()),
          body: _bodyOfPage(blocState));
    });
  }

  Widget _bodyOfPage(ChatPageState blocState) {
    if ((blocState.event is EnterChatRoomEvent) &&
        (blocState.state == BlocState.noInternet)) {
      return NoInternetView(onPressed: () {
        _enterInChatRoom();
      });
    }
    return Padding(
        padding: KEdgeInsets.kOnly(l: 20.w, r: 20.w, b: 20.h),
        child: Column(
          children: [
            Expanded(child: _messagesListing()),
            Gap(5.h),
            const ChatMessageTextField(),
          ],
        ));
  }

  Widget _messagesListing() {
    if ((controller.state.event is EnterChatRoomEvent) &&
        (controller.state.state == BlocState.loading)) {
      return const ChatPageMessageListingShimmer(itemCount: 10);
    }
    return ListView.separated(
        shrinkWrap: true,
        reverse: true,
        controller: scrollController,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          late bool showDateHeader;
          if (store.messagesList.length == 1) {
            showDateHeader = true;
          } else if (index == store.messagesList.length - 1) {
            showDateHeader = true;
          } else {
            DateTime currentMsgDate = DateTime.fromMillisecondsSinceEpoch(
                store.messagesList[index].created ?? 0);
            DateTime nextMsgDate = DateTime.fromMillisecondsSinceEpoch(
                store.messagesList[index + 1].created ?? 0);
            showDateHeader = DateTime(currentMsgDate.year, currentMsgDate.month,
                    currentMsgDate.day) !=
                DateTime(nextMsgDate.year, nextMsgDate.month, nextMsgDate.day);
          }
          return ChatCard(
              model: store.messagesList[index], showDateHeader: showDateHeader);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: fieldGap);
        },
        itemCount: store.messagesList.length);
  }
}
