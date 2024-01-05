import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/app.dart';
import 'package:flutter_dev_toys/app/view/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

void main() {
  group('smoke test - pump', () {
    testWidgets('empty app', (tester) => tester.pumpApp(const SizedBox()));
    testWidgets('app', (tester) => tester.pumpApp(const App()));
    testWidgets('home', (tester) => tester.pumpApp(const HomeScreen()));
  });
}
