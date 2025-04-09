import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/render_components.dart/gap/gap.dart';
import 'package:flutter/material.dart';

/// Common scaffolf with app bar(Mostly used in settings page)
class SettingsCommonScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final MainAxisAlignment alignment;
  const SettingsCommonScaffold({
    super.key,
    required this.title,
    required this.child,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBar(title: title),
      body: SingleChildScrollView(
        padding: KEdgeInsets.k(h: pageHorizontalPadding),
        child: Column(
          mainAxisAlignment: alignment,
          children: [Gap(commonPadding), child],
        ),
      ),
    );
  }
}
