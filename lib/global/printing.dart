import 'dart:convert';
import 'package:cobuild/utils/logger.dart';

/// Class used for Dev logs

String prettifyMap(dynamic input) {
  try {
    var encoder = JsonEncoder.withIndent('  ', (obj) => obj.toString());
    var prettyprint = encoder.convert(input);
    return prettyprint;
  } catch (e) {
    return input.toString();
  }
}

void printCustom(dynamic object, [Logger logger = Logger.blue]) {
  var data = prettifyMap(object);
  logger.log(data);
}

void printLocal(dynamic object) {
  printCustom(object, Logger.green);
}

void printPersistent(dynamic object) {
  printCustom(object, Logger.cyan);
}
