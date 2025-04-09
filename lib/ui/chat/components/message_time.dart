import 'package:cobuild/global/global.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:intl/intl.dart';

// Show time of Message
class MessageTime extends StatelessWidget {
  final int? time;
  const MessageTime({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Text(
      getTimeFromTimestamp((time == 0 || time == null)
          ? DateTime.now().millisecondsSinceEpoch
          : time),
      style: AppStyles().smallRegular.colored(AppColors.lightGreyText),
    );
  }

  /// Seprate messages based on date.
  Widget chatDateSeparator() {
    String date = DateFormat('EEEE, d MMM yyyy').format(time == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(time ?? 0));
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 2.0,
              color: const Color(0xFFD8D8D8),
              width: 63,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              date,
            ),
          ),
          Expanded(
            child: Container(
              height: 2.0,
              color: const Color(0xFFD8D8D8),
              width: 63,
            ),
          ),
        ],
      ),
    );
  }
}
