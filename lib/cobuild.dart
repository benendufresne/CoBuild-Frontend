import 'package:cobuild/bloc/controller/app_controller/app_bloc.dart';
import 'package:cobuild/bloc/controller/auth_bloc/auth_controller.dart';
import 'package:cobuild/bloc/controller/bottom_navigation_bloc/bottom_navigation_controller.dart';
import 'package:cobuild/bloc/controller/chat/chat_inbox_bloc/chat_inbox_controller.dart';
import 'package:cobuild/bloc/controller/chat/chat_page_bloc/chat_page_controller.dart';
import 'package:cobuild/bloc/controller/dynamic_map_bloc/dynamic_map_controller.dart';
import 'package:cobuild/bloc/controller/estimates/active_estimates_bloc/active_estimates_controller.dart';
import 'package:cobuild/bloc/controller/estimates/completed_estimate_bloc/completed_estimate_controller.dart';
import 'package:cobuild/bloc/controller/estimates/estimate_request_bloc/estimate_request_controller.dart';
import 'package:cobuild/bloc/controller/estimates/estimates_bloc/estimate_controller.dart';
import 'package:cobuild/bloc/controller/notification_bloc/notification_controller.dart';
import 'package:cobuild/bloc/controller/report_damage/damage_report_data/damage_report_controller.dart';
import 'package:cobuild/bloc/controller/faq_bloc/faq_controller.dart';
import 'package:cobuild/bloc/controller/job/job_listing_bloc/job_listing_controller.dart';
import 'package:cobuild/bloc/controller/my_profile_bloc/my_profile_controller.dart';
import 'package:cobuild/bloc/controller/network_bloc/network_bloc.dart';
import 'package:cobuild/bloc/controller/otp_verification_bloc/verify_otp_bloc.dart';
import 'package:cobuild/bloc/controller/service_category/service_category_controller.dart';
import 'package:cobuild/bloc/controller/tutorial_bloc/tutorial_controller.dart';
import 'package:cobuild/bloc/controller/upload_media_bloc/upload_media_controller.dart';
import 'package:cobuild/bloc/controller/user_profile_bloc/user_profile_controller.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_helpers/app_theme.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// First page of application , that hanldes the flow of app
class CoBuild extends StatelessWidget {
  const CoBuild({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NetworkController()),
          BlocProvider(create: (_) => AuthController()),
          BlocProvider(create: (_) => MyProfileController()),
          BlocProvider(create: (_) => TutorialController()),
          BlocProvider(create: (_) => VerifyOtpController()),
          BlocProvider(create: (_) => AppController()),
          BlocProvider(create: (_) => FAQController()),
          BlocProvider(create: (_) => BottomNavigationController()),
          BlocProvider(create: (_) => UserProfileController()),
          BlocProvider(create: (_) => JobListingController()),
          BlocProvider(create: (_) => DamageReportListingController()),
          BlocProvider(create: (_) => ServiceCategoryController()),
          BlocProvider(create: (_) => DynamicMapController()),
          // Estimate
          BlocProvider(create: (_) => ActiveEstimateController()),
          BlocProvider(create: (_) => CompletedEstimateController()),
          BlocProvider(create: (_) => EstimateRequestController()),
          BlocProvider(create: (_) => EstimateController()),
          // Upload Media
          BlocProvider(create: (_) => UploadMediaController()),
          // Notifications
          BlocProvider(create: (_) => NotificationsController()),
          // Chat
          BlocProvider(create: (_) => ChatInboxController()),
          BlocProvider(create: (_) => ChatPageController())
        ],
        child: GestureDetector(
            onTap: () {
              /// To hide keyboard while tapping outside of text field.
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0), boldText: false),
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: Locale(selectedLanguage),
                supportedLocales: S.delegate.supportedLocales,
                title: 'CoBuild',
                theme: ThemeData(
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
                    useMaterial3: true,
                    appBarTheme: const AppBarTheme(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white),
                    scaffoldBackgroundColor: AppColors.appBackGroundColor),
                builder: (context, child) {
                  SilverAttuner.init(context, const Size(393, 850));
                  return ThemeStore(child: child ?? const SizedBox());
                },
                routerConfig: AppRouter.router,
              ),
            )));
  }
}
