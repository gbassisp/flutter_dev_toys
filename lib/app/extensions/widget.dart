import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget constrained({
    double? size,
    double? height,
    double? width,
    double? maxHeight,
    double? maxWidth,
    double? minHeight,
    double? minWidth,
  }) =>
      ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: size ?? height ?? maxHeight ?? double.infinity,
          maxWidth: size ?? width ?? maxWidth ?? double.infinity,
          minHeight: size ?? height ?? minHeight ?? 0,
          minWidth: size ?? width ?? minWidth ?? 0,
        ),
        child: this,
      );

  Widget get withSize => constrained(minHeight: 0.0001, minWidth: 0.0001);
}
