import 'package:cobuild/main.dart';
import 'package:cobuild/ui/components/show_image.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_images.dart';
import 'package:cobuild/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Splash screen to show app logo
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _initResources();
  }

  _initResources() async {
    await initResources();
    _checkLoginStatus();
  }

  // check login status -----------------------------------------
  _checkLoginStatus() async {
    if (mounted) {
      String initRoute = getInitialRoute();
      context.goNamed(initRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: ShowImage(image: AppImages.logoWhite),
      ),
    );
  }
}
