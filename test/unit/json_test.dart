import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json validation', () {
    test('encoded json validation', () {
      expect(jsonDecode('{}'), <String, dynamic>{});
      expect(jsonDecode('"{"'), '{');
    });
  });
}
