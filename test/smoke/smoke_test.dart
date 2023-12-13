import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('smoke test - pump', () {
    testWidgets('empty app', (tester) => tester.pumpApp(const SizedBox()));
  });
}
