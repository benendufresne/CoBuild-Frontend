import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

/// Verify OTP common components
class VerifyOtpComponents {
  static void keyboardOptimisation(
      ScrollController controller, double keyboardHeight) {
    Future.delayed(const Duration(milliseconds: 0)).then(
      (value) {
        if (controller.hasClients &&
            keyboardHeight > 0 &&
            (controller.position.pixels <
                controller.position.maxScrollExtent - 0.1.sp)) {
          controller.animateTo(
            controller.position.maxScrollExtent,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 100),
          );
        }
      },
    );
  }
}
