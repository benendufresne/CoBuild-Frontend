import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/global/printing.dart';
import 'package:cobuild/utils/app_helpers/debouncer.dart';
import 'package:cobuild/utils/app_keys.dart';
import 'package:cobuild/utils/app_preferences.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Deep linkmanager to handles the scanned job request from outside of app.
class DeeplinkManager {
  void handleDeepLink() async {
    await FlutterBranchSdk.init();
    FlutterBranchSdk.listSession().listen((data) {
      if (data['+non_branch_link'] == null) {
        return;
      }
      String cobuildData = data['+non_branch_link'];
      if (cobuildData.contains(ApiKeys.jobId)) {
        String? jobId = cobuildData.split("${ApiKeys.jobId}=").last;
        if (jobId.isNotEmpty) {
          _navigateToJobPage(jobId);
        }
      } else if (cobuildData.contains(ApiKeys.deleteAccount)) {
        if (AppPreferences.isLoggedIn) {
          if (ctx.mounted) {
            ctx.goNamed(AppRoutes.bottomNavigation);
            ctx.pushNamed(AppRoutes.deleteAccount);
          }
        }
      }
    }, onError: (error) {
      printCustom('listSession error: ${error.toString()}');
    });
  }

  static Future<String> generatePostShareDeepLink() async {
    try {
      var response = await FlutterBranchSdk.getShortUrl(
        buo: BranchUniversalObject(
          canonicalIdentifier: 'cobuild',
          title: 'jobData',
          contentMetadata: BranchContentMetaData()
            ..addCustomMetadata('\$deeplink_path', 'cobuildApp')
            ..addCustomMetadata('\$ios_deeplink_path', 'cobuild')
            ..addCustomMetadata('route', 'JOB_DETAIL')
            ..addCustomMetadata('jobId', '67a9bb3b88ec127850f2bbc3'),
          keywords: ['Plugin', 'Branch', 'Flutter', 'cobuild'],
          publiclyIndex: true,
          locallyIndex: true,
        ),
        linkProperties: BranchLinkProperties(
          channel: 'facebook',
          feature: 'marketing',
          stage: 'Job Id',
          campaign: 'campaign',
        ),
      );
      printLocal('Generated Deep Link: ${response.result}');
      return response.result.toString();
    } catch (e) {
      printLocal('Deep Link Generation Error: $e');
      return '';
    }
  }

  Future<void> _handleIncomingLinks() async {
    print("android data1");
    final appLinks = AppLinks(); //
    // StreamSubscription? sub;
    // It will handle app links while the app is already started - be it in
    // the foreground or in the background.
    final uri = await appLinks.getInitialLink();
    print("android data2");
    if (uri != null) {
      if (uri.path.isNotEmpty) {
        String? jobId = uri.path.split("${ApiKeys.jobId}=").last;
        if (jobId.isNotEmpty) {
          _navigateToJobPage(jobId);
        }
      }
      print(
          "android data3 and uri param ${uri.queryParameters} and link ${uri.path} and data ${uri.data} and query ${uri.query}");
      String url =
          "https://api.branch.io/v1/url?branch_key=key_live_ducYMvXvG3UueQ21A4PfwlfnqthDGZAj&url=${baseUrlModel.deepLinkBaseUrl}${uri.path}";
      http.get(Uri.parse(url)).then((value) {
        print("android data4");
        print("android data5 ${jsonDecode(value.body)}");
      });
    }
    appLinks.uriLinkStream.listen((Uri? uri) {
      print("android data6");
      String url =
          "https://api.branch.io/v1/url?branch_key=key_live_ducYMvXvG3UueQ21A4PfwlfnqthDGZAj&url=${baseUrlModel.deepLinkBaseUrl}${uri?.path}";
      if (!isBlank(uri?.path)) {
        print("android data7");
        http.get(Uri.parse(url)).then((value) {
          print("android data8 ${jsonDecode(value.body)['data']}");
        });
      }
    }, onError: (Object err) {});
  }

  void _navigateToJobPage(String jobId) {
    if (AppPreferences.isLoggedIn) {
      DeBouncer deBouncer = DeBouncer(milliseconds: 2000);
      deBouncer.run(() {
        ctx.pushNamed(AppRoutes.jobDetails, extra: {AppKeys.id: jobId});
      });
    }
  }
}
