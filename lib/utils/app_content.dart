import 'package:cobuild/models/tutorial_model/tutorial_model.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';

class AppContent {
  // list of Onboarding Tutorial Content
  static List<TutorialModel> tutorialContents() {
    return [
      TutorialModel(
          image: AppImages.tutorial1,
          title: S.current.tutorial1Title,
          description: S.current.tutorial1Description),
      TutorialModel(
          image: AppImages.tutorial2,
          title: S.current.tutorial2Title,
          description: S.current.tutorial2Description),
      TutorialModel(
          image: AppImages.tutorial3,
          title: S.current.tutorial3Title,
          description: S.current.tutorial3Description),
    ];
  }
}
