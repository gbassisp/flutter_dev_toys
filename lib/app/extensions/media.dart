import 'package:flutter/material.dart';

extension MediaQueryExtensions on MediaQueryData {
  bool get isCompact => size.shortestSide < 400;
}
