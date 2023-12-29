import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

final throwsAny = throwsA(anything);

void main() {
  group('learning tests', () {
    test('jsonDecode throws when invalid', () {
      expect(() => jsonDecode('{'), throwsAny);
    });
  });
}
