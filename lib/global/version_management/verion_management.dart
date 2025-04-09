import 'dart:io';
import 'package:cobuild/bloc/controller/app_controller/app_bloc.dart';
import 'package:cobuild/bloc/controller/app_controller/app_event.dart';
import 'package:cobuild/global/global.dart';
import 'package:cobuild/models/version_management/app_version/app_version_model.dart';
import 'package:cobuild/ui/widgets/common_dialog.dart';
import 'package:cobuild/utils/app_constant.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionManagement {
  int buildNumberAndroid = 1;
  int buildNumberIos = 1;
  AppController controller = ctx.read<AppController>();
  checkAppVersion() {
    return;
    controller.add(const CheckAppVersionEvent());
  }

  showUpdateDialog({required AppVersionModel model}) async {
    bool isForceUpdate = false;
    bool showUpdate = false;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.tryParse(packageInfo.buildNumber) ?? 1;
    int currentBuildNumber = buildNumber;
    //    Platform.isAndroid ? buildNumberAndroid : buildNumberIos;
    if (model.forcefull != null) {
      if (int.parse(model.forcefull?.version ?? '0') > currentBuildNumber) {
        isForceUpdate = true;
        showUpdate = true;
      }
    }
    if (model.normal != null) {
      if (int.parse(model.normal?.version ?? '0') > currentBuildNumber) {
        showUpdate = true;
      }
    }
    if (!showUpdate) {
      return;
    }
    DialogBox().commonDialog(
        title: S.current.updateApplication,
        positiveText: S.current.update,
        subtitle: S.current.updateAppMessage,
        onTapPositive: () {
          _openAppStoreToUpdate();
        },
        negativeText: isForceUpdate ? null : S.current.later,
        isDismissible: !isForceUpdate);
  }

  _openAppStoreToUpdate() async {
    String url = Platform.isAndroid
        ? AppConstant.androidAppLink
        : AppConstant.iosAppLink;
    customLaunchUrl(url);
  }

  Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "${packageInfo.version} (${packageInfo.buildNumber})";
  }
}
