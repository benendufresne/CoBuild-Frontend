import 'package:cobuild/bloc/base/bloc_builder.dart';
import 'package:cobuild/bloc/controller/tutorial_bloc/tutorial_controller.dart';
import 'package:cobuild/bloc/controller/tutorial_bloc/tutorial_state.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/ui/onboarding/background_pattern.dart';
import 'package:cobuild/ui/onboarding/tutorials/tutorial_item.dart';
import 'package:cobuild/ui/widgets/app_common_button.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_content.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Tutorial main screen
class TutorialScreen extends StatefulWidget {
  final bool initTutorial;
  const TutorialScreen({super.key, this.initTutorial = true});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the PageController with the initial page set to 0.
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // Dispose of the PageController to free up resources when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.initTutorial) {
      return _bodyOfPage();
    }
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _bodyOfPage().topRightLogo,
    );
  }

  Widget _bodyOfPage() {
    return BlocBuilderNew<TutorialController, TutorialState>(
        defaultView: (blocState) {
      return SingleChildScrollView(
        padding: KEdgeInsets.k(h: pageHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(gapFromTopToShowPattern),
            Center(
                child: ShowImage(
                    image: AppImages.logo, height: 70.h, width: 60.w)),
            // skip button if not the last tutorial screen.
            //_skipButton(blocState),
            // PageView for displaying tutorial content.
            Column(
              children: [
                Gap(45.h),
                TutorialItem(
                  image: AppContent.tutorialContents()[0].image,
                  title: AppContent.tutorialContents()[0].title,
                  description: AppContent.tutorialContents()[0].description,
                  index: 0,
                ),
                // Gap(0.028 * deviceHeight),
                // _progressIndicator(blocState),
                Gap(35.h),
                AppCommonButton(
                    buttonName: S.current.getStarted,
                    onPressed: _onSkipDone,
                    isExpanded: true),
              ],
            ),
          ],
        ),
      );
    });
  }

//skip function ---------------------------------
  void _onSkipDone() async {
    await AppPreferences.setTutorialSeen();
    if (mounted) {
      context.goNamed(AppRoutes.login);
    }
  }
}
