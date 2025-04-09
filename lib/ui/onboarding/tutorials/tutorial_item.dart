import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/widgets/app_rich_text.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Tutorial common items
class TutorialItem extends StatelessWidget {
  final String image;
  final String description;
  final String title;
  final int index;

  const TutorialItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 273.h,
              child: ShowImage(
                image: image,
                type: ImageType.local,
              ),
            )),
        Gap(52.h),
        //title----------------------------------------------------
        getTitle(),
        Gap(8.h),
        //description----------------------------------------------------
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppStyles()
              .regularSemiBold
              .colored(AppColors.black.withOpacity(0.7)),
        ),
      ],
    );
  }

  Widget getTitle() {
    switch (index) {
      case 0:
        return _title1();
      case 1:
        return _title2();
      case 2:
        return _title3();
      default:
        return _title1();
    }
  }

  Widget _title1() {
    return AppRichText(children: [
      _titleBlack(S.current.Streamline),
      _titleGreen(" ${S.current.yourBuild}"),
      _titleBlack(" ${S.current.withText} "),
      _titleGreen(S.current.cobuild),
    ]);
  }

  Widget _title2() {
    return AppRichText(children: [
      _titleBlack(S.current.Streamline),
      _titleGreen(" ${S.current.yourBuild}"),
      _titleBlack(" ${S.current.withText} "),
      _titleGreen(S.current.cobuild),
    ]);
  }

  Widget _title3() {
    return AppRichText(children: [
      _titleBlack(S.current.Streamline),
      _titleGreen(" ${S.current.yourBuild}"),
      _titleBlack(" ${S.current.withText} "),
      _titleGreen(S.current.cobuild),
    ]);
  }

  AppTextSpan _titleBlack(String title) {
    return AppTextSpan(
        text: title,
        style: AppStyles().tutorialTitle.colored(AppColors.blackText));
  }

  AppTextSpan _titleGreen(String title) {
    return AppTextSpan(
        text: title,
        style: AppStyles().tutorialTitle.colored(AppColors.primaryColor));
  }
}
