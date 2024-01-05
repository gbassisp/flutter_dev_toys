import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget constrained({
    double? max,
    double? min,
    double? maxHeight,
    double? maxWidth,
    double? minHeight,
    double? minWidth,
  }) =>
      ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight ?? max ?? double.infinity,
          maxWidth: maxWidth ?? max ?? double.infinity,
          minHeight: minHeight ?? min ?? 0,
          minWidth: minWidth ?? min ?? 0,
        ),
        child: this,
      );

  Widget get withSize => constrained(minHeight: 0.0001, minWidth: 0.0001);
}

extension SnackBarExtension on BuildContext {
  void showSnackMessage(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
}
