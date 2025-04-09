import 'package:cobuild/global/global.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

/// Country code picker widget
class CountryCodepickerWidget extends StatefulWidget {
  final String intialSelection;
  final Function(CountryCode val) onChange;

  const CountryCodepickerWidget(
      {super.key, required this.onChange, this.intialSelection = ""});

  @override
  State<CountryCodepickerWidget> createState() => _CountryCodepickerState();
}

class _CountryCodepickerState extends State<CountryCodepickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CountryCodePicker(
            enabled: false,
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(0),
            initialSelection: isNotBlank(widget.intialSelection)
                ? widget.intialSelection
                : defaultCountryCode.code,
            hideMainText: true,
            alignLeft: true,
            flagWidth: 24.w,
            onChanged: (val) {
              widget.onChange(val);
            }),
        Container(
          height: 15,
          width: 1,
          color: AppColors.black,
        ),
        Gap(12.w)
      ],
    );
  }
}
