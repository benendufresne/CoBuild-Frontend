import 'dart:io';

import 'package:cobuild/bloc/controller/auth_bloc/auth_controller.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_event.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/onboarding/social_signup/social_signup_model.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/components/text/title2.dart';
import 'package:cobuild/ui/widgets/app_common_widgets.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Social login options
class SocialLoginOptions extends StatefulWidget {
  const SocialLoginOptions({super.key});

  @override
  State<StatefulWidget> createState() => _SocialLoginOptionsState();
}

class _SocialLoginOptionsState extends State<SocialLoginOptions> {
  late AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return _socialLoginOptions();
  }

  Widget _socialLoginOptions() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: AppCommonDivider()),
            Padding(
              padding: KEdgeInsets.k(h: 20.w),
              child: Title2(title: S.current.orLoginWith, fontSize: 13),
            ),
            const Expanded(child: AppCommonDivider()),
          ],
        ),
        Gap(22.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Apple
            if (Platform.isIOS) ...[
              _socialLogin(
                  image: AppImages.apple,
                  onPressed: () {
                    controller.add(SocialLoginEvent(
                        model: SocialSignUpModel(
                            socialLoginType:
                                SocialLoginType.apple.backendEnum)));
                  }),
              Gap(majorGap)
            ],

            /// Google
            _socialLogin(
                image: AppImages.google,
                onPressed: () {
                  controller.add(SocialLoginEvent(
                      model: SocialSignUpModel(
                          socialLoginType:
                              SocialLoginType.google.backendEnum)));
                },
                isSvg: false),
            // Gap(majorGap),

            // /// Facebook
            // _socialLogin(image: AppImages.facebook, onPressed: () {}),
          ],
        ),
      ],
    );
  }

  Widget _socialLogin(
      {required String image,
      required Function() onPressed,
      bool isSvg = true}) {
    return InkWell(
        splashColor: AppColors.transparent,
        onTap: () {
          onPressed();
        },
        child: ShowImage(
          image: image,
          height: 48.h,
          width: 48.h,
          type: isSvg ? ImageType.svgLocal : ImageType.local,
        ));
  }
}
