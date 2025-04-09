import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_helpers/app_theme.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// To handle text style in complete App
class AppStyles extends TextStyle {
  static AppStyles of(BuildContext context) => AppTheme.of(context).styles;
  static AppStyles ofStatic(BuildContext context) =>
      AppTheme.ofStatic(context).styles;

  //----------------------------------------------------------------------------
  static TextStyle appFont = TextStyle(
    fontSize: 14.sp,
    color: AppColors.blackText,
    fontFamily: 'Manrope',
    fontVariations: const [FontVariation('wght', 400)],
  );

  //----------------------------------------------------------------------------
  AppStyles.create([TextStyle? basic])
      : basic = basic ?? appFont,
        super(
          color: (basic ?? appFont).color,
          fontSize: (basic ?? appFont).fontSize,
          fontWeight: (basic ?? appFont).fontWeight,
          fontStyle: (basic ?? appFont).fontStyle,
          fontFamily: (basic ?? appFont).fontFamily,
          decoration: (basic ?? appFont).decoration,
          fontVariations: (basic ?? appFont).fontVariations,
          locale: (basic ?? appFont).locale,
          height: (basic ?? appFont).height,
        );

  static final AppStyles instance = AppStyles.create();
  factory AppStyles() => instance;

  //----------------------------------------------------------------------------
  final TextStyle basic;
  TextStyle get extraLargeTitle =>
      sized(32).wBolder.colored(AppColors.semiBlue);
  TextStyle get tutorialTitle => sized(19.sp).wBolder;

  TextStyle get tooLarger => sized(28.sp).wRegular;
  TextStyle get textFieldError => sSmall.wSemiBold.cRed.copyWith(
        letterSpacing: 0.4,
      );
  TextStyle get label =>
      sSmall.wRegular.colored(AppColors.primaryColor).copyWith(
            letterSpacing: 0.4,
          );

  TextStyle get threeTwoRegular => sized(32).wRegular;

  /// Synced app style
  TextStyle get aapBarTitle => largeBold.colored(AppColors.appBarBlack);
  TextStyle get buttonText => sMedium.wSemiBold;
  TextStyle get toast => sMedium.wSemiBold.colored(AppColors.white);
  TextStyle get smallRegular => sSmall.wRegular;
  TextStyle get smallSemiBold => sSmall.wSemiBold;
  TextStyle get sExtraSmallwRegular => sExtraSmall.wRegular;
  TextStyle get sExtraSmallwBolder => sExtraSmall.wBolder;
  TextStyle get smallSmall => sSmall.wLight;
  TextStyle get regularSemiBold => sRegular.wSemiBold;
  TextStyle get regularRegular => sRegular.wRegular;
  TextStyle get largeBold => sLarge.wBold;
  TextStyle get largerBold => sLarger.wBold;
  TextStyle get largerRegular => sLarger.wRegular;
  TextStyle get extraLarger => wBolder.sExtraLarger;
  TextStyle get sExtraLargerRegular => sExtraLarger.wRegular;
  TextStyle get largeRegular => sLarge.wRegular;
  TextStyle get largeBolder => sLarge.wBolder;
  TextStyle get mediumBold => sMedium.wBold;
  TextStyle get mediumRegular => sMedium.wRegular;
  TextStyle get mediumBolder => sMedium.wBolder;
  TextStyle get regularBold => sRegular.wBold;
  TextStyle get smallBold => sSmall.wBold;
  TextStyle get regularBolder => sRegular.wBolder;
  TextStyle get mediumSemibold => sMedium.wSemiBold;
  TextStyle get smallBolder => sSmall.wBolder;
  TextStyle get sExtraLargeRegular => sExtraLarge.wRegular;
  TextStyle get sExtraLargeBolder => sExtraLarge.wBolder;
  TextStyle get mediumLight => sMedium.wLight;
  TextStyle get header1 => sExtraLargerHeader1.wBolder;
  TextStyle get sSmallSemiBlock => sSmall.wSemiBlock;
  TextStyle get sLargeSemiBlock => sLarge.wSemiBlock;

  /// Text Field style
  TextStyle get textField => sRegular.wSemiBold.colored(AppColors.blackText);
}
