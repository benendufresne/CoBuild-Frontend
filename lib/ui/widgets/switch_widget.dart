import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Common switch widget
class SwitchWidget extends StatelessWidget {
  final bool value;
  final Color? inactiveTrackColor;
  final void Function()? onChanged;
  const SwitchWidget(
      {super.key,
      required this.value,
      required this.onChanged,
      this.inactiveTrackColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onChanged != null) {
          onChanged!();
        }
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: value
                  ? ShowImage(
                      image: AppImages.toogleSelected,
                      height: 22.h,
                      width: 35.w,
                    )
                  : ShowImage(
                      image: AppImages.toogleUnselected,
                      height: 22.h,
                      width: 35.w))),
    );
  }
}
