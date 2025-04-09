import 'package:cobuild/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:cobuild/utils/sliver_attuner.dart';

/// Chat messages :- receiver view
class ChatReceiverContainer extends StatelessWidget {
  final Widget child;

  const ChatReceiverContainer({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300.w),
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 14.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.r),
            bottomRight: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          ),
          color: AppColors.white),
      child: child,
    );
  }
}
