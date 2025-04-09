import 'package:cobuild/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// common contaner for decoaration of message

class ChatSenderContainer extends StatelessWidget {
  final Widget child;

  const ChatSenderContainer({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300.w),
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 14.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            bottomRight: Radius.circular(8.r),
            bottomLeft: Radius.circular(8.r),
          ),
          color: AppColors.primaryColor),
      child: child,
    );
  }
}
