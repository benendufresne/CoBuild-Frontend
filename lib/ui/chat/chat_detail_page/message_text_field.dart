import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_controller.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_event.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_state.dart';
import 'package:cobuild/ui/widgets/common_text_field.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/enums/chat_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Input text field for chat
class ChatMessageTextField extends StatefulWidget {
  const ChatMessageTextField({super.key});

  @override
  State<StatefulWidget> createState() => _ChatMessageTextFieldState();
}

class _ChatMessageTextFieldState extends State<ChatMessageTextField> {
  late ChatPageController controller;
  late ChatPageStateStore store;
  @override
  void initState() {
    super.initState();
    controller = context.read<ChatPageController>();
    store = controller.state.stateStore;
  }

  @override
  Widget build(BuildContext context) {
    return _messageField();
  }

  Widget _messageField() {
    return BlocBuilderNew<ChatPageController, ChatPageState>(
        defaultView: (blocState) {
      bool isDisable = isDisableChat;
      return AppTextField(
        hintText: "${S.current.message}...",
        controller: store.messageController,
        maxLength: AppConstant.chatMessageMaxLength,
        textInputAction: TextInputAction.newline,
        isLableRequired: false,
        fillColor: isDisable
            ? AppColors.disableButtonTextColor.withOpacity(0.15)
            : null,
        enabled: !isDisable,
        onChange: (val) {
          setState(() {});
        },
        suffixIcon: store.messageController.text.trim().isNotEmpty
            ? InkWell(
                onTap: () {
                  controller.add(SendMessageEvent());
                },
                child: const Icon(Icons.send, color: AppColors.primaryColor))
            : const SizedBox(),
      );
    });
  }

  bool get isDisableChat {
    switch (MessageStatus.getStatusType(store.chatRoomModel?.status)) {
      case MessageStatus.active:
        return false;
      default:
        return true;
    }
  }
}
