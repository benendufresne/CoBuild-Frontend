import 'package:cobuild/ui/components/app_bar.dart';
import 'package:flutter/material.dart';

/// Common scaffold used in complete app :- with common appbar
class AppCommonScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  const AppCommonScaffold({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.appBar(title: title),
      body: child,
    );
  }
}
