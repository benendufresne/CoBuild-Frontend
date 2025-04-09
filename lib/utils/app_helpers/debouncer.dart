import 'dart:async';

import 'package:flutter/foundation.dart';

/// To reduce the number of calls to the api
class DeBouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DeBouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) _timer!.cancel();

    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }
}
