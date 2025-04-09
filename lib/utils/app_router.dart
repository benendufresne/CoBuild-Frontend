import 'dart:io';

import 'package:cobuild/bloc/controller/change_password_bloc/change_password_controller.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_details_bloc/estimate_details_controller.dart';
import 'package:cobuild/bloc/controller/job/filter_bloc/filter_controller.dart';
import 'package:cobuild/bloc/controller/job/job_details/job_details_controller.dart';
import 'package:cobuild/bloc/controller/job/search_jobs_bloc/search_jobs_controller.dart';
import 'package:cobuild/bloc/controller/report_damage/add_damage_report/add_damage_report_controller.dart';
import 'package:cobuild/bloc/controller/delete_account_bloc/delete_account_controller.dart';
import 'package:cobuild/bloc/controller/edit_profile_bloc/edit_profile_controller.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_details_bloc/damage_report_details_controller.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/estimates/estimate_model/create_estimate_model.dart';
import 'package:cobuild/models/jobs/job_model.dart';
import 'package:cobuild/models/media_model/media_model.dart';
import 'package:cobuild/models/user_model/user_model.dart';
import 'package:cobuild/models/verify_otp_model/verify_otp_model.dart';
import 'package:cobuild/ui/bottom_navigation/bottom_navigation_page.dart';
import 'package:cobuild/ui/chat/inbox/chat_inbox_page.dart';
import 'package:cobuild/ui/chat/chat_detail_page/chat_page.dart';
import 'package:cobuild/ui/components/image_editor/image_editor.dart';
import 'package:cobuild/ui/estimates/create_estimate_request/estimate_request_form.dart';
import 'package:cobuild/ui/estimates/estimates_page.dart';
import 'package:cobuild/ui/estimates/estimate_request_detail_page.dart';
import 'package:cobuild/ui/home_page/jobs/job_listing/job_listing_screen.dart';
import 'package:cobuild/ui/home_page/filter_jobs_screen.dart';
import 'package:cobuild/ui/home_page/dynamic_map/dynamic_map_view.dart';
import 'package:cobuild/ui/home_page/jobs/job_details_page.dart';
import 'package:cobuild/ui/home_page/scan_job/scan_job.dart';
import 'package:cobuild/ui/home_page/search_job_page.dart';
import 'package:cobuild/ui/my_profile/change_password.dart';
import 'package:cobuild/ui/my_profile/edit_profile_page.dart';
import 'package:cobuild/ui/my_profile/setting_page.dart';
import 'package:cobuild/ui/my_profile/settings/delete_account.dart';
import 'package:cobuild/ui/my_profile/settings/faq.dart';
import 'package:cobuild/ui/my_profile/settings/manage_notifications.dart';
import 'package:cobuild/ui/my_profile/settings/static_content_page.dart';
import 'package:cobuild/ui/my_profile/settings/support.dart';
import 'package:cobuild/ui/onboarding/complete_profile.dart';
import 'package:cobuild/ui/onboarding/complete_profile_for_social_login.dart';
import 'package:cobuild/ui/onboarding/forgot_password.dart';
import 'package:cobuild/ui/onboarding/login_page.dart';
import 'package:cobuild/ui/onboarding/reset_password.dart';
import 'package:cobuild/ui/onboarding/signup.dart';
import 'package:cobuild/ui/onboarding/splash.dart';
import 'package:cobuild/ui/onboarding/tutorials/tutorial_screen.dart';
import 'package:cobuild/ui/onboarding/verify_otp.dart';
import 'package:cobuild/ui/components/pdf_viewer/view_pdf.dart';
import 'package:cobuild/ui/report_damage/image_preview/images_preview_screen.dart';
import 'package:cobuild/ui/report_damage/report_damage.dart';
import 'package:cobuild/ui/report_damage/reported_damage_details.dart';
import 'package:cobuild/ui/search_location/search_location.dart';
import 'package:cobuild/ui/widgets/error_page.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

/// Class to handle navigation from one screen to another
String getInitialRoute() {
  if (AppPreferences.isLoggedIn) {
    return AppRoutes.bottomNavigation;
  } else if (AppPreferences.isTutorialSeen) {
    return AppRoutes.login;
  } else {
    return AppRoutes.tutorial;
  }
}

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String tutorial = '/tutorial';
  static const String verifyOtp = '/verifyOtp';
  static const String forgotPassword = '/forgotPassword';
  static const String resetPassword = '/resetPassword';
  static const String bottomNavigation = '/bottomNavigation';
  static const String completeProfile = '/completeProfile';
  static const String completeProfileForSocialLogin =
      "/completeProfileForSocialLogin";
  static const String imagePreviewScreen = "/imagePreviewScreen";

  // My Profile
  static const String setting = '/setting';
  static const String editProfile = '/editProfile';
  static const String changePassword = '/changePassword';
  static const String manageNotifications = '/manageNotifications';
  static const String faq = '/faq';
  static const String support = '/support';
  static const String deleteAccount = '/deleteAccount';
  static const String staticContentPage = "/staticContentPage";
  static const String searchLocation = "/searchLocation";
  static const String openPdf = "/openPdf";

  /// Home Page
  static const String searchJobs = '/searchJobs';
  static const String filterJobs = '/filterJobs';
  static const String nearByJobs = '/nearByJobs';
  static const String jobDetails = '/jobDetails';
  static const String dynamicMap = "/dynamicMap";
  static const String scanJobQR = '/scanJobQR';

  // Estimates
  static const String estimates = "/estimates";
  static const String estimatesRequestForm = "/estimatesRequestForm";
  static const String estimateRequestDetails = "/estimateRequestDetails";
  static const String editImage = '/editImage';

  // Damage Report
  static const String damageReportForm = "/damageReportForm";
  static const String reportDetailsPage = "/reportDetailsPage";

  // Chat
  static const String chatInboxPage = "/chatMainPage";
  static const String chatPage = "/chatPage";
}

class AppRouter {
  static final GoRouter router = GoRouter(navigatorKey: navigatorKey, routes: [
    GoRoute(
      name: "initial",
      path: "/",
      builder: (context, state) => const SizedBox(),
      redirect: (context, state) async {
        if (Platform.isAndroid) {
          return AppRoutes.splash;
        }
        return getInitialRoute();
      },
    ),
    GoRoute(
      name: AppRoutes.splash,
      path: AppRoutes.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const Splash();
      },
    ),
    GoRoute(
      name: AppRoutes.tutorial,
      path: AppRoutes.tutorial,
      builder: (BuildContext context, GoRouterState state) {
        return const TutorialScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.login,
      path: AppRoutes.login,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      name: AppRoutes.signup,
      path: AppRoutes.signup,
      builder: (BuildContext context, GoRouterState state) {
        Map? data = state.extra as Map?;
        if (data != null && data[AppKeys.id] != null) {
          String socialLoginId = data[AppKeys.id] as String;
          return SignupPage(socialLoginId: socialLoginId);
        }
        return const SignupPage();
      },
    ),
    GoRoute(
      name: AppRoutes.forgotPassword,
      path: AppRoutes.forgotPassword,
      builder: (BuildContext context, GoRouterState state) {
        return const ForgotPassword();
      },
    ),
    GoRoute(
      name: AppRoutes.resetPassword,
      path: AppRoutes.resetPassword,
      builder: (BuildContext context, GoRouterState state) {
        return const ResetPasswordScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.verifyOtp,
      path: AppRoutes.verifyOtp,
      builder: (BuildContext context, GoRouterState state) {
        VerifyOtpModel? model = state.extra as VerifyOtpModel?;
        return VerifyOtpScreen(model: model);
      },
    ),
    GoRoute(
      name: AppRoutes.completeProfile,
      path: AppRoutes.completeProfile,
      builder: (BuildContext context, GoRouterState state) {
        return const CompleteProfileScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.completeProfileForSocialLogin,
      path: AppRoutes.completeProfileForSocialLogin,
      builder: (BuildContext context, GoRouterState state) {
        Map? data = state.extra as Map?;
        if (data != null && data[AppKeys.model] != null) {
          UserModel initialIndex = data[AppKeys.model] as UserModel;
          return CompleteProfileForSocialLoginScreen(model: initialIndex);
        }
        return const CompleteProfileForSocialLoginScreen();
      },
    ),
    GoRoute(
        name: AppRoutes.bottomNavigation,
        path: AppRoutes.bottomNavigation,
        builder: (BuildContext context, GoRouterState state) {
          Map? data = state.extra as Map?;
          if (data != null && data[AppKeys.initialIndex] != null) {
            int initialIndex = data[AppKeys.initialIndex] as int;
            return BottomNavigationPage(initialIndex: initialIndex);
          }
          return const BottomNavigationPage();
        }),
    GoRoute(
        name: AppRoutes.setting,
        path: AppRoutes.setting,
        builder: (BuildContext context, GoRouterState state) {
          return const SettingPage();
        }),
    GoRoute(
        name: AppRoutes.changePassword,
        path: AppRoutes.changePassword,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider<ChangePasswordController>(
              create: (_) => ChangePasswordController(),
              child: const ChangePasswordPage());
        }),
    GoRoute(
        name: AppRoutes.editProfile,
        path: AppRoutes.editProfile,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider<EditProfileController>(
            create: (_) => EditProfileController(),
            child: const EditProfilePage(),
          );
        }),
    GoRoute(
        name: AppRoutes.manageNotifications,
        path: AppRoutes.manageNotifications,
        builder: (BuildContext context, GoRouterState state) {
          return const ManageNotificationsPage();
        }),
    GoRoute(
        name: AppRoutes.faq,
        path: AppRoutes.faq,
        builder: (BuildContext context, GoRouterState state) {
          return const FAQPage();
        }),
    GoRoute(
        name: AppRoutes.deleteAccount,
        path: AppRoutes.deleteAccount,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider<DeleteAccountController>(
            create: (_) => DeleteAccountController(),
            child: const DeleteAccountPage(),
          );
        }),
    GoRoute(
        name: AppRoutes.support,
        path: AppRoutes.support,
        builder: (BuildContext context, GoRouterState state) {
          return const SupportPage();
        }),
    GoRoute(
        name: AppRoutes.staticContentPage,
        path: AppRoutes.staticContentPage,
        builder: (BuildContext context, GoRouterState state) {
          StaticContentEnum type = state.extra as StaticContentEnum;
          return StaticContentPage(
            pageType: type,
          );
        }),
    GoRoute(
        name: AppRoutes.searchLocation,
        path: AppRoutes.searchLocation,
        builder: (BuildContext context, GoRouterState state) {
          return const SearchLocationScreen();
        }),
    GoRoute(
        name: AppRoutes.searchJobs,
        path: AppRoutes.searchJobs,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider<SearchJobsController>(
              create: (_) => SearchJobsController(),
              child: const SearchJobScreen());
        }),
    GoRoute(
        name: AppRoutes.filterJobs,
        path: AppRoutes.filterJobs,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider<FilterController>(
              create: (_) => FilterController(),
              child: const FilterJobScreen());
        }),
    GoRoute(
        name: AppRoutes.nearByJobs,
        path: AppRoutes.nearByJobs,
        builder: (BuildContext context, GoRouterState state) {
          return const JobListingScreen();
        }),
    GoRoute(
        name: AppRoutes.jobDetails,
        path: AppRoutes.jobDetails,
        builder: (BuildContext context, GoRouterState state) {
          Map? data = state.extra as Map?;
          if (data != null && data[AppKeys.id] != null) {
            String id = data[AppKeys.id] as String;
            return BlocProvider<JobDetailsController>(
                create: (_) => JobDetailsController(),
                child: JobDetailsPage(
                  id: id,
                ));
          } else {
            return const ErrorPage();
          }
        }),
    GoRoute(
        name: AppRoutes.dynamicMap,
        path: AppRoutes.dynamicMap,
        builder: (BuildContext context, GoRouterState state) {
          JobModel? model;
          Map? data = state.extra as Map?;
          if (data != null && data[AppKeys.model] != null) {
            model = data[AppKeys.model] as JobModel;
          }
          return DynamicMapView(model: model);
        }),
    GoRoute(
        name: AppRoutes.estimates,
        path: AppRoutes.estimates,
        builder: (BuildContext context, GoRouterState state) {
          return const EstimatesPage();
        }),
    GoRoute(
        name: AppRoutes.estimatesRequestForm,
        path: AppRoutes.estimatesRequestForm,
        builder: (BuildContext context, GoRouterState state) {
          Map? data = state.extra as Map?;
          if (data != null && data[AppKeys.model] != null) {
            EstimateRequestModel model =
                data[AppKeys.model] as EstimateRequestModel;
            return EstimateRequestForm(
              model: model,
            );
          } else {
            return const EstimateRequestForm();
          }
        }),
    GoRoute(
        name: AppRoutes.estimateRequestDetails,
        path: AppRoutes.estimateRequestDetails,
        builder: (BuildContext context, GoRouterState state) {
          Map? data = state.extra as Map?;
          if (data != null && data[AppKeys.id] != null) {
            String id = data[AppKeys.id] as String;
            return BlocProvider<EstimateDetailsController>(
                create: (_) => EstimateDetailsController(),
                child: EstimateRequestDetailPage(
                  id: id,
                ));
          } else {
            return const ErrorPage();
          }
        }),
    GoRoute(
        name: AppRoutes.damageReportForm,
        path: AppRoutes.damageReportForm,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider<AddDamageController>(
              create: (_) => AddDamageController(),
              child: const DamageReportForm());
        }),
    GoRoute(
        name: AppRoutes.reportDetailsPage,
        path: AppRoutes.reportDetailsPage,
        builder: (BuildContext context, GoRouterState state) {
          Map? data = state.extra as Map?;
          if (data != null && data[AppKeys.id] != null) {
            String id = data[AppKeys.id] as String;
            return BlocProvider<DamageReportDetailsController>(
                create: (_) => DamageReportDetailsController(),
                child: ReportDamageDetailPage(
                  id: id,
                ));
          } else {
            return const ErrorPage();
          }
        }),
    GoRoute(
        name: AppRoutes.scanJobQR,
        path: AppRoutes.scanJobQR,
        builder: (BuildContext context, GoRouterState state) {
          return const ScanJobQR();
        }),
    GoRoute(
        name: AppRoutes.openPdf,
        path: AppRoutes.openPdf,
        builder: (BuildContext context, GoRouterState state) {
          Map? data = state.extra as Map?;
          String? path, url;
          if (data != null) {
            path = data[AppKeys.path];
            url = data[AppKeys.url];
          }
          return PDFScreen(path: path, pdfUrl: url);
        }),
    GoRoute(
        name: AppRoutes.editImage,
        path: AppRoutes.editImage,
        builder: (BuildContext context, GoRouterState state) {
          Map? data = state.extra as Map?;
          if (data != null && data[AppKeys.file] != null) {
            XFile file = data[AppKeys.file];
            return ImageEditorExample(file: file);
          } else {
            return const ErrorPage();
          }
        }),
    GoRoute(
        name: AppRoutes.imagePreviewScreen,
        path: AppRoutes.imagePreviewScreen,
        builder: (BuildContext context, GoRouterState state) {
          var currentIndex = 0;
          var images = [];

          if (state.extra != null) {
            var args = state.extra as List<dynamic>;
            currentIndex = args[0];
            images = args[1];
          }
          return ImagePreviewScreen(
            currentIndex: currentIndex,
            images: images as List<MediaModel>,
          );
        }),

    /// Chat
    GoRoute(
        name: AppRoutes.chatInboxPage,
        path: AppRoutes.chatInboxPage,
        builder: (BuildContext context, GoRouterState state) {
          return const ChatMainPage();
        }),
    GoRoute(
        name: AppRoutes.chatPage,
        path: AppRoutes.chatPage,
        builder: (BuildContext context, GoRouterState state) {
          Map? data = state.extra as Map?;
          if (data != null && data[AppKeys.id] != null) {
            String id = data[AppKeys.id];
            return ChatPage(id: id);
          } else {
            return const ErrorPage();
          }
        }),
  ]);
}
