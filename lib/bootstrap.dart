import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:lean_extensions/lean_extensions.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Add cross-flavor configuration here
  LeanExtensions.charactersForRandomChar =
      '${LeanExtensions.charactersForRandomChar}!@#%^&*()';

  runApp(await builder());
}
