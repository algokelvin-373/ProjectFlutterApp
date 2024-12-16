import 'package:flutter/foundation.dart';

class FlutterModeConfig {
  static bool get isFree => kDebugMode; // for free mode
  static bool get isPaid => kReleaseMode; // for paid mode

  static String get flutterMode => isFree
      ? "debug"
      : isPaid
          ? "release"
          : "unknown";

}
