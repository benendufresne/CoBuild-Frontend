import 'package:cobuild/models/chat/message_model/message_model.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:flutter/widgets.dart';

/// Show actual text of chat message
class MessageWidget extends StatelessWidget {
  final MessageModel model;
  const MessageWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    bool sender = model.senderId == AppPreferences.userId;
    return Text(model.message?.trim() ?? '',
        style: AppStyles()
            .regularRegular
            .copyWith(color: (sender) ? AppColors.white : AppColors.blackText));
  }
}
