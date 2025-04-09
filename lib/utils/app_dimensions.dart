import 'package:cobuild/utils/sliver_attuner.dart';
import 'package:flutter/material.dart';

extension KBorderRadius on BorderRadius {
  // same radius for all corners
  static BorderRadius kAll12 = BorderRadius.circular(12.r);
  static BorderRadius kAll16 = BorderRadius.circular(16);
}

extension KEdgeInsets on EdgeInsets {
  // zero
  static EdgeInsets get kZero => EdgeInsets.zero;
  static EdgeInsets k({double? h, double? v}) =>
      EdgeInsets.symmetric(horizontal: h ?? 0, vertical: v ?? 0);
  static EdgeInsets kall({double? a}) => EdgeInsets.all(a ?? 0);
  static EdgeInsets kOnly({double? l, double? r, double? t, double? b}) =>
      EdgeInsets.only(left: l ?? 0, right: r ?? 0, top: t ?? 0, bottom: b ?? 0);
  // all sides same value
  static EdgeInsets k4 = EdgeInsets.all(4.sp);
  static EdgeInsets k6 = EdgeInsets.all(6.sp);
  static const EdgeInsets k8 = EdgeInsets.all(8);
  static EdgeInsets k10 = EdgeInsets.all(10.sp);
  static const EdgeInsets k12 = EdgeInsets.all(12);
  static EdgeInsets k14 = EdgeInsets.all(14.sp);
  static EdgeInsets k16 = EdgeInsets.all(16.sp);
  static EdgeInsets k20 = EdgeInsets.all(20.sp);

  // Horizontal Sides same
  static EdgeInsets kHorizontal4 = EdgeInsets.symmetric(horizontal: 4.sp);
  static EdgeInsets kHorizontal10 = const EdgeInsets.symmetric(horizontal: 10);
  static EdgeInsets kHorizontal16 = EdgeInsets.symmetric(horizontal: 16.sp);
  static EdgeInsets kHorizontal20 = EdgeInsets.symmetric(horizontal: 20.sp);
  static EdgeInsets kHorizontal24 = EdgeInsets.symmetric(horizontal: 24.sp);

  // Vertical Sides same
  static EdgeInsets kVertical6 = EdgeInsets.symmetric(vertical: 6.sp);
  static EdgeInsets kVertical10 = EdgeInsets.symmetric(vertical: 10.sp);
  static const EdgeInsets kVertical12 = EdgeInsets.symmetric(vertical: 12);
  static EdgeInsets kVertical14 = EdgeInsets.symmetric(vertical: 14.sp);
  static EdgeInsets get kVertical16 => const EdgeInsets.symmetric(vertical: 16);

  // Only Left
  static const EdgeInsets kLeft10 = EdgeInsets.only(left: 10);

  // Only Bottom
  static EdgeInsets kBottom6 = EdgeInsets.only(bottom: 6.sp);

  // Only
  static EdgeInsets kHorizontal16Vertical24 =
      EdgeInsets.symmetric(horizontal: 16.sp, vertical: 24.sp);
}

extension KDuration on Duration {
  static const Duration k200mls = Duration(milliseconds: 200);
}
