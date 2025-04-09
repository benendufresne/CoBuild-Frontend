import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

/// To show html data in text format
class HTMLReader extends StatelessWidget {
  final String html;
  final TextStyle? style;

  const HTMLReader({super.key, required this.html, this.style});
  @override
  Widget build(BuildContext context) {
    return HtmlWidget(html, textStyle: style);
  }
}
