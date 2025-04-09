import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Custom RichText widget
class AppRichText extends StatelessWidget {
  const AppRichText(
      {required this.children, this.maxLine, super.key, this.alignment});

  final TextAlign? alignment;
  final int? maxLine;
  final List<AppTextSpan> children;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: getTextSpans()),
      textAlign: alignment ?? TextAlign.start,
      maxLines: maxLine,
    );
  }

  List<TextSpan> getTextSpans() {
    return children
        .map((span) => TextSpan(
              text: span.text,
              style: span.style,
              recognizer: () {
                var rec = span.gesture?.constructor();
                if (rec != null) {
                  span.gesture?.initializer(rec);
                }
                return rec;
              }(),
            ))
        .toList();
  }
}

class AppTextSpan extends TextSpan {
  const AppTextSpan({
    super.children,
    super.text,
    super.style,
    this.gesture,
  });

  final GestureRecognizerFactory? gesture;
}

class TapGestureRecognizerFactoryController
    extends GestureRecognizerFactoryWithHandlers<TapGestureRecognizer> {
  TapGestureRecognizerFactoryController(
      void Function(TapGestureRecognizer) initializer)
      : super(() => TapGestureRecognizer(), initializer);
}
