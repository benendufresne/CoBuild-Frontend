import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Failed view widget along with retry option
class FailedView extends StatelessWidget {
  final void Function() onPressed;
  final String? message;
  const FailedView({super.key, required this.onPressed, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Gap(50.spMin),
        Align(
          alignment: Alignment.center,
          child: Text(
            message ?? S.current.somethingWentWrongWithoutRetry,
            style: AppStyles().mediumBolder,
          ),
        ),
        Gap(30.sp),
        SizedBox(
            width: deviceWidth * 0.33,
            child: AppCommonButton(
                buttonName: S.current.retry, onPressed: onPressed)),
        Gap(50.sp),
      ],
    );
  }
}
