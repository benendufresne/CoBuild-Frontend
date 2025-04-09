// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:cobuild/global/printing.dart';
import 'package:cobuild/models/onboarding/social_signup/facebook_response_model.dart';
import 'package:cobuild/models/onboarding/social_signup/social_signup_model.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// To get social login data
class SocialLogins {
  static FacebookAuth facebookInstance = FacebookAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();
  static Future<SocialSignUpModel?> facebookLogin() async {
    SocialSignUpModel? model;
    try {
      // fields: 'email,name,mobile_phone,picture'
      await facebookInstance.logOut();
      await facebookInstance.login().then((value) async {
        if (value.status == LoginStatus.success) {
          await facebookInstance.getUserData().then((userData) async {
            printCustom("response of facebook is $userData");
            if (userData['id'].isNotEmpty) {
              FacebookResponseModel? responseModel =
                  FacebookResponseModel.fromJson(userData);
              if (responseModel.id?.isNotEmpty ?? false) {
                model = SocialSignUpModel(
                  socialLoginId: responseModel.id,
                  email: responseModel.email,
                  isEmailVerified: (responseModel.email?.isNotEmpty),
                  name: responseModel.name,
                  socialLoginType: SocialLoginType.facebook.backendEnum,
                );
              }
            }
          });
        }
      });
      return model;
    } catch (e) {
      printCustom(e);
    }
    return null;
  }

  static Future<SocialSignUpModel?> googleLogin() async {
    SocialSignUpModel? model;

    try {
      googleSignIn.signOut();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        await googleSignInAccount.authentication;
        if (googleSignInAccount.email.isNotEmpty &&
            (googleSignInAccount.id.isNotEmpty)) {
          model = SocialSignUpModel(
              socialLoginId: googleSignInAccount.id,
              email: googleSignInAccount.email,
              isEmailVerified: (googleSignInAccount.email.isNotEmpty),
              name: googleSignInAccount.displayName,
              socialLoginType: SocialLoginType.google.backendEnum);
        }
      }
      return model;
    } catch (e) {
      printCustom(e);
    }
    return null;
  }

  static Future<SocialSignUpModel?> appleLogin() async {
    SocialSignUpModel? model;
    String? previousSavedEmail;
    try {
      AuthorizationCredentialAppleID? credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      if (credential.identityToken?.isNotEmpty ?? false) {
        // Save Apple data in preferences :-
        if (credential.email?.isEmpty ?? true) {
          String savedAppleEmailData = AppPreferences.appleLoginData;
          if (savedAppleEmailData.contains(credential.userIdentifier ?? '')) {
            List<String> emailDataInList = savedAppleEmailData.split("&&");
            if (emailDataInList.isNotEmpty && emailDataInList.length == 2) {
              previousSavedEmail = emailDataInList[1];
              printCustom(
                  "previous Saved Email in apple login is $previousSavedEmail");
            }
          }
        } else {
          AppPreferences.setAppleLoginData(
              "${credential.userIdentifier}&&${credential.email}");
        }
        //
        model = SocialSignUpModel(
          socialLoginType: SocialLoginType.apple.backendEnum,
          socialLoginId: credential.userIdentifier,
          name: credential.givenName,
          isEmailVerified:
              ((credential.email ?? previousSavedEmail)?.isNotEmpty ?? false),
        );
        if ((credential.email ?? previousSavedEmail)?.isNotEmpty ?? false) {
          model.email = credential.email ?? previousSavedEmail;
        }
      }
      return model;
    } catch (e) {
      printCustom(e);
    }
    return null;
  }
}
