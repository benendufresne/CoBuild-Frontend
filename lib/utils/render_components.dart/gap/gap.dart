import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'render_gap.dart';

/// Global class to create Widget using Gap
class Gap extends LeafRenderObjectWidget {
  const Gap(this.size, {super.key});

  final double size;

  double get effectiveSize {
    if (size.isNegative || !size.isFinite) {
      return 0;
    } else {
      return size;
    }
  }

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderGap(extent: effectiveSize);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderGap renderObject,
  ) {
    renderObject.extent = effectiveSize;
  }
}
