import 'dart:io';
import 'dart:typed_data';
import 'package:another_flushbar/flushbar.dart';
import 'package:cobuild/bloc/controller/bottom_navigation_bloc/bottom_navigation_controller.dart';
import 'package:cobuild/bloc/controller/bottom_navigation_bloc/bottom_navigation_event.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/models/base_url_model.dart';
import 'package:cobuild/models/notifications/notification_model.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:cobuild/utils/app_styles.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/enums/notification_enum.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Set app build type
BuildType appBuildType = BuildType.prod;

// Accepted Media Type
List<String> acceptedImageTypes = ['.jpg', '.jpeg', '.png'];
// Check file size (5 MB limit)
int maxImageSize = 5 * 1024 * 1024;

BaseUrlModel get baseUrlModel {
  switch (appBuildType) {
    case BuildType.dev:
      return BaseUrlModel(
          adminBaseUrl: AdminBaseUrl.devBaseUrl,
          deepLinkBaseUrl: DeepLinkBaseUrl.devBaseUrl,
          mediaBaseUrl: S3ImageBaseUrl.devBaseUrl,
          socketBaseUrl: SocketBaseUrl.devBaseUrl,
          apiBaseUrl: AppBaseUrl.devBaseUrl);
    case BuildType.qa:
      return BaseUrlModel(
          adminBaseUrl: AdminBaseUrl.qaBaseUrl,
          deepLinkBaseUrl: DeepLinkBaseUrl.qaBaseUrl,
          mediaBaseUrl: S3ImageBaseUrl.qaBaseUrl,
          socketBaseUrl: SocketBaseUrl.qaBaseUrl,
          apiBaseUrl: AppBaseUrl.qaBaseUrl);
    case BuildType.staging:
      return BaseUrlModel(
          adminBaseUrl: AdminBaseUrl.stageBaseUrl,
          deepLinkBaseUrl: DeepLinkBaseUrl.stageBaseUrl,
          mediaBaseUrl: S3ImageBaseUrl.stagingBaseUrl,
          socketBaseUrl: SocketBaseUrl.stageBaseUrl,
          apiBaseUrl: AppBaseUrl.stageBaseUrl);
    case BuildType.prod:
      return BaseUrlModel(
          adminBaseUrl: AdminBaseUrl.productionBaseUrl,
          deepLinkBaseUrl: DeepLinkBaseUrl.productionBaseUrl,
          mediaBaseUrl: S3ImageBaseUrl.prodBaseUrl,
          socketBaseUrl: SocketBaseUrl.productionBaseUrl,
          apiBaseUrl: AppBaseUrl.productionBaseUrl);
  }
}

/// Set api timeout
const Duration apiTimeOut = Duration(minutes: 2);

double fieldGap = 16.h;
double commonPadding = 20.sp;
double majorGap = 24.sp;
double majorGapVertical = 24.h;
double pageHorizontalPadding = 20.w;

/// Top and Bottom of page
double pageVerticalPadding = 20.h;
double gapFromTopToShowPattern = 68.h;

/// defaultCountryCode
CountryCode defaultCountryCode = CountryCode(
    code: "US", dialCode: "+1", flagUri: "flags/us.png", name: "United States");
String selectedLanguage = 'en';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'BaseApp');
BuildContext get ctx => navigatorKey.currentState!.context;
double deviceHeight = MediaQuery.of(ctx).size.height;
double deviceWidth = MediaQuery.of(ctx).size.width;
double keyboardHeight = MediaQuery.of(ctx).viewInsets.bottom;

bool isNotBlank(dynamic object) => !isBlank(object);

bool isBlank(dynamic object) {
  if (object == null) {
    return true;
  } else {
    if (object is List || object is String || object is Map) {
      return object.isEmpty;
    } else {
      return false;
    }
  }
}

///common snackbar
showSnackBar({
  required String? message,
  bool isSuccess = false,
  bool isHome = false,
  bool isMultipleData = false,
  int duration = 3,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(message ?? S.current.somethingWentWrong,
        style: AppStyles.of(ctx)
            .toast
            .copyWith(color: isSuccess ? AppColors.white : null)),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(ctx).viewInsets.bottom,
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor:
        isSuccess ? AppColors.primaryColor : AppColors.errorMsgColor,
    duration: Duration(seconds: duration),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0))),
    //behavior: isHome ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
  );
  ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}

customLaunchUrl(String url) async {
  try {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  } catch (err) {
    printCustom("error ${err.toString()}");
  }
}

extension StringExtensions on String {
  String get capitalizedString =>
      split(' ').map((word) => word.capitalize).join(' ');

  String get capitalize => "${this[0].toUpperCase()}${substring(1)}";
}

onTapTextfield(GlobalKey globalKey) async {
  // await Future.delayed(const Duration(milliseconds: 400));
  // RenderObject? object = globalKey.currentContext?.findRenderObject();
  // object?.showOnScreen();
}

void unfocusTextField() {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
}

Color onboardingTextFieldColor = AppColors.black.withOpacity(0.025);

String timeAgo(int? timestamp) {
  final now = DateTime.now();
  final time =
      timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : now;
  final difference = now.difference(time);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    int minutes = difference.inMinutes;
    if (minutes == 1) {
      return '$minutes minute ago';
    }
    return '$minutes minutes ago';
  } else if (difference.inHours < 24) {
    int hours = difference.inHours;
    if (hours == 1) {
      return '$hours hour ago';
    }
    return '$hours hours ago';
  } else if (difference.inDays < 7) {
    int days = difference.inDays;
    if (days == 1) {
      return '$days day ago';
    }
    return '$days days ago';
  } else if (difference.inDays < 30) {
    int weeks = (difference.inDays / 7).floor();
    if (weeks == 1) {
      return '$weeks week ago';
    }
    return '$weeks weeks ago';
  } else if (difference.inDays < 365) {
    int months = (difference.inDays / 30).floor();
    if (months == 1) {
      return '$months month ago';
    }
    return '$months months ago';
  } else {
    int years = (difference.inDays / 365).floor();
    if (years == 1) {
      return '$years year ago';
    }
    return '$years years ago';
  }
}

/// Map Custom Marker Icon :-
BitmapDescriptor? markerIcon;
Future<void> initMarker() async {
  markerIcon ??= await _createCustomIcon(AppImages.mapMarker);
}

Future<BitmapDescriptor> _createCustomIcon(String assetPath) async {
  final ByteData byteData = await DefaultAssetBundle.of(ctx).load(assetPath);
  final ui.Codec codec = await ui
      .instantiateImageCodec(byteData.buffer.asUint8List(), targetWidth: 32);
  final ui.FrameInfo frameInfo = await codec.getNextFrame();

  final ByteData? pngBytes =
      await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.bytes(pngBytes!.buffer.asUint8List());
}

String formatDate(int? timestamp) {
  if (timestamp == null) return '';
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

  // Get day with ordinal suffix
  String dayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  final String day = dayWithSuffix(date.day);
  final String month = DateFormat('MMMM').format(date); // Full month name
  final String year = DateFormat('yyyy').format(date); // Year

  return '$day $month $year';
}

String getDayOfWeek(int? timestamp) {
  if (timestamp == null) return '';
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('EEEE').format(date); // Returns the full name of the day
}

String getTimeFromTimestamp(int? timestamp) {
  if (timestamp == null) return '';
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('h:mm a').format(date); // Formats time as "11:00 AM"
}

bool isImageFile(File? selectedMedia) {
  if (acceptedImageTypes
      .any((item) => (selectedMedia?.path.endsWith(item) ?? false))) {
    return true;
  }
  // if ((selectedMedia?.path.endsWith('.jpg') ?? false) ||
  //     (selectedMedia?.path.endsWith('.jpeg') ?? false) ||
  //     (selectedMedia?.path.endsWith('.png') ?? false)) {
  //   return true;
  // }
  return false;
}

showOfflineDialog() {
  return Flushbar(
    messageText: Text(
      S.current.offlineMessage,
      style: AppStyles().regularSemiBold.colored(AppColors.white),
      textAlign: TextAlign.center,
    ),
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: AppColors.errorMsgColor,
    animationDuration: const Duration(microseconds: 900),
    isDismissible: false,
  )..show(ctx);
}

void navigateNotificationToDetailsPage(NotificationModel model) {
  switch (NotificaionTypeEnum.parse(model.type)) {
    case NotificaionTypeEnum.profileUpdated:
      ctx.goNamed(AppRoutes.bottomNavigation);
      ctx
          .read<BottomNavigationController>()
          .add(const ChangeSelectedTabEvent(type: BottomNavEnum.profile));
    case NotificaionTypeEnum.damageReportStatusUpdate:
      String? reportId = model.details?.reportId ?? model.reportId;
      if (reportId?.isNotEmpty ?? false) {
        ctx.goNamed(AppRoutes.bottomNavigation);
        ctx.pushNamed(AppRoutes.reportDetailsPage,
            extra: {AppKeys.id: reportId});
      }
    case NotificaionTypeEnum.estimateRequestAccepted:
    case NotificaionTypeEnum.estimateRequestRejected:
      String? requestId = model.details?.requestId ?? model.requestId;
      if (requestId?.isNotEmpty ?? false) {
        ctx.goNamed(AppRoutes.bottomNavigation);
        ctx.pushNamed(AppRoutes.estimateRequestDetails,
            extra: {AppKeys.id: requestId});
      }
    case NotificaionTypeEnum.none:
      return;
  }
}
