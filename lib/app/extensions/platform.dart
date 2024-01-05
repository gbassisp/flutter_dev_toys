import 'package:flutter/foundation.dart';

TargetPlatform get platform => defaultTargetPlatform;

extension TargetPlatformExtensions on TargetPlatform {
  bool get isMobile =>
      this == TargetPlatform.android || this == TargetPlatform.iOS;

  bool get isDesktop => !isMobile;
}
