import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerUtils {
  static var logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      printEmojis: true,
      // ignore: deprecated_member_use
      printTime: false,
    ),
  );

  static void logException(String title, dynamic object) {
    if (kDebugMode) {
      logger.e('### Exception : $title , error: $object');
    }
  }
}
