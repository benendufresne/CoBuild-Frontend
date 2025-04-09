import 'package:cobuild/bloc/repositories/global_repo.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/static_content_model/static_content_model.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';

enum BuildType { dev, staging, prod, qa }

enum ApiRequest { apiGet, apiPost, apiPut, apiPatch, apiDelete }

enum ApiContentType { json, formData, formUrlEncoded }

enum FieldValidation { invalid, valid, none }

enum SocialLoginType { apple, google, facebook }

enum StaticContentEnum { privacyPolicy, tAndC, aboutUs }

extension StaticContentEnumExtension on StaticContentEnum {
  StaticContentModel get typeValue {
    switch (this) {
      case StaticContentEnum.privacyPolicy:
        return StaticContentModel(
            url: GlobalRepository.staticContentModel.privacyPolicy,
            heading: S.current.privacyPolicy.capitalizedString);
      case StaticContentEnum.tAndC:
        return StaticContentModel(
            url: GlobalRepository.staticContentModel.termsAndConditions,
            heading: S.current.termsAndConditions);
      case StaticContentEnum.aboutUs:
        return StaticContentModel(
            url: GlobalRepository.staticContentModel.aboutUs,
            heading: S.current.aboutUs);
    }
  }
}

extension SocialLoginTypeExtension on SocialLoginType {
  String get stringName {
    switch (this) {
      case SocialLoginType.apple:
        return 'apple';
      case SocialLoginType.google:
        return 'google';
      case SocialLoginType.facebook:
        return 'facebook';
    }
  }

  String get backendEnum {
    switch (this) {
      case SocialLoginType.apple:
        return "APPLE";
      case SocialLoginType.google:
        return "GOOGLE";
      case SocialLoginType.facebook:
        return "FACEBOOK";
    }
  }
}

enum BottomNavEnum {
  home,
  report,
  notification,
  profile;

  static int getIndex(BottomNavEnum? type) {
    switch (type) {
      case home:
        return 0;
      case report:
        return 1;
      case notification:
        return 2;
      case profile:
        return 3;
      default:
        return 0;
    }
  }
}
