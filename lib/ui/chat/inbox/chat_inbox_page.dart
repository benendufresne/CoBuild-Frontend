import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/base/bloc_states.dart';
import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_controller.dart';
import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_event.dart';
import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_state.dart';
import 'package:cobuild/models/chat/chat_inbox/chat_inbox_model.dart';
import 'package:cobuild/ui/chat/inbox/chat_inbox_card.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/components/common_widgets.dart';
import 'package:cobuild/ui/home_page/jobs/job_listing/empty_job_listing.dart';
import 'package:cobuild/ui/shimmer_files/chat/chat_inbox_listing_shimmer.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/ui/widgets/no_internet_view.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_helpers/debouncer.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Chat Main page :- Inbox Listing
class ChatMainPage extends StatefulWidget {
  const ChatMainPage({super.key});

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  late ChatInboxController controller;
  final _debouncer = DeBouncer(milliseconds: 800);
  FocusNode focusNode = FocusNode();
  late ScrollController scrollController;
  late ChatInboxListStateStore store;
  final bool isEmpty = false;

  @override
  void initState() {
    super.initState();
    controller = context.read<ChatInboxController>();
    store = controller.state.stateStore;
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    _initPage();
    _getChatListing();
  }

  void _initPage() {
    controller.add(InitChatInboxPageEvent());
  }

  void _onScroll() {
    if ((scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) &&
        !(controller.state.event is GetChatInboxListEvent &&
            controller.state.state == BlocState.loading)) {
      // Fetch the next page messages
      _debouncer.run(() {
        controller.add(GetChatInboxListEvent(isNextPage: true));
      });
    }
  }

  void _getChatListing() {
    controller.add(GetChatInboxListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar.appBar(title: S.current.chat),
        body: BlocBuilderNew<ChatInboxController, ChatInboxListState>(
            noInternetView: (blocState) {
          if ((blocState.event is GetChatInboxListEvent) &&
              (store.list.models.isEmpty)) {
            return NoInternetView(onPressed: () {
              _getChatListing();
            });
          }
          return _bodyOfPage();
        }, defaultView: (blocState) {
          return _bodyOfPage();
        }));
  }

  Widget _bodyOfPage() {
    return Padding(
      padding: KEdgeInsets.k20,
      child: isEmpty
          ? EmptyListing(title: S.current.noMessages)
          : Column(
              children: [
                _searchField(),
                Gap(20.h),
                Expanded(child: _inboxListing()),
              ],
            ),
    );
  }

  Widget _searchField() {
    return AppTextField(
      onChange: (value) async {
        setState(() {});
        _debouncer.run(() async {
          _searchInboxList();
        });
      },
      focusNode: focusNode,
      isLableRequired: false,
      textInputAction: TextInputAction.next,
      maxLength: AppConstant.chatSearchMaxLength,
      hintText: S.current.search,
      controller: controller.searchChatController,
      keyboardType: TextInputType.name,
      prefixWidget: Padding(
        padding: EdgeInsets.fromLTRB(12.h, 16.h, 8.h, 16.h),
        child: CommonWidgets.searchIcon(),
      ),
      suffixIcon: controller.searchChatController.text.isNotEmpty
          ? IconButton(
              onPressed: () {
                controller.searchChatController.clear();
                setState(() {
                  _searchInboxList();
                });
              },
              icon: const Icon(Icons.close_rounded))
          : null,
    );
  }

  void _searchInboxList() {
    controller.add(GetChatInboxListEvent(
        searchText: controller.searchChatController.text.trim()));
  }

  Widget _inboxListing() {
    if (controller.state.event is GetChatInboxListEvent &&
        controller.state.state == BlocState.loading) {
      return const ChatInboxListingShimmer(itemCount: 10);
    } else if ((controller.state.event is UpdataInboxListDataEvent) &&
        (store.list.models.isEmpty)) {
      return EmptyListing(title: S.current.noChatFound);
    }
    return RefreshIndicator(
      onRefresh: () async => _getChatListing(),
      child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 4);
          },
          controller: scrollController,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            ChatInboxModel model = store.list.models[index];
            return ChatInboxCard(
                model: model,
                isFirstTile: index == 0,
                isLastTile: index == store.list.models.length - 1);
          },
          itemCount: store.list.models.length),
    );
  }
}
