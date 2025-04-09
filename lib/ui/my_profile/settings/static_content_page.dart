import 'package:cobuild/global/global.dart';
import 'package:cobuild/ui/components/app_bar.dart';
import 'package:cobuild/ui/widgets/app_common_loader.dart';
import 'package:cobuild/utils/app_colors.dart';
import 'package:cobuild/utils/app_dimensions.dart';
import 'package:cobuild/utils/app_helpers/app_strings/l10n.dart';
import 'package:cobuild/utils/enums/app_enums.dart';
import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Static content page as:- privacy , terms and conditions
class StaticContentPage extends StatefulWidget {
  final StaticContentEnum pageType;

  const StaticContentPage({super.key, required this.pageType});

  @override
  State<StatefulWidget> createState() => _StaticContentPageState();
}

class _StaticContentPageState extends State<StaticContentPage> {
  late WebViewController _controller;
  bool loadingPage = false;
  bool pageFinished = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (value) {
          if (!pageFinished) {
            loadingPage = true;
            setState(() {});
          }
        },
        onPageFinished: (value) {
          loadingPage = false;
          pageFinished = true;
          setState(() {});
        },
        onWebResourceError: (value) {
          loadingPage = false;
          setState(() {});
        },
        onNavigationRequest: (request) {
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.pageType.typeValue.url ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            CommonAppBar.appBar(title: widget.pageType.typeValue.heading ?? ''),
        body: _bodyOfPage());
  }

  Widget _bodyOfPage() {
    return Container(
        margin: KEdgeInsets.k(h: commonPadding, v: 20.h),
        constraints: BoxConstraints(minHeight: 1.sp),
        padding: KEdgeInsets.k16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r), color: AppColors.white),
        child: loadingPage
            ? const Center(child: CommonLoader())
            : ClipRRect(
                borderRadius: KBorderRadius.kAll12,
                child: isBlank(widget.pageType.typeValue.url)
                    ? Center(child: Text(S.current.noContentFound))
                    : WebViewWidget(controller: _controller)));
  }
}
