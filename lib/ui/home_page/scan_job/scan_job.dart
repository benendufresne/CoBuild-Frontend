import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/common_scaffold.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:cobuild/utils/app_keys.dart';

/// Logic handler after scaning any job
class ScanJobQR extends StatefulWidget {
  const ScanJobQR({super.key});

  @override
  State<StatefulWidget> createState() => _ScanJobQRState();
}

class _ScanJobQRState extends State<ScanJobQR> {
  final MobileScannerController controller = MobileScannerController();
  bool scanned = false;
  String qrPrefix = baseUrlModel.deepLinkBaseUrl;
  DateTime? lastInvalidMessageTime;

  @override
  Widget build(BuildContext context) {
    return AppCommonScaffold(
        title: S.current.scanQR,
        child: Padding(
            padding: KEdgeInsets.kOnly(t: deviceHeight * 0.05),
            child: SizedBox(
              height: deviceHeight * 0.6,
              width: deviceWidth,
              child: MobileScanner(
                controller: controller,
                onDetect: (capture) {
                  if (!scanned) {
                    String? id = capture.barcodes.first.displayValue;
                    if (id?.isNotEmpty ?? false) {
                      if (id?.contains(qrPrefix) ?? false) {
                        String? jobId = id?.split("${ApiKeys.jobId}=").last;
                        if (jobId?.isNotEmpty ?? false) {
                          context.pop();
                          context.pushNamed(AppRoutes.jobDetails,
                              extra: {AppKeys.id: jobId});
                          scanned = true;
                        }
                      } else {
                        _showInvalidQRMessage();
                      }
                    }
                  }
                },
                onDetectError: (obj, error) {
                  _showInvalidQRMessage();
                },
              ),
            )));
  }

  _showInvalidQRMessage() {
    DateTime currentTime = DateTime.now();
    if (lastInvalidMessageTime == null ||
        currentTime
                .difference(lastInvalidMessageTime ?? currentTime)
                .inSeconds >
            15) {
      lastInvalidMessageTime = currentTime;
      showSnackBar(message: S.current.invalidQR);
    }
  }
}
