import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';
import 'package:lean_extensions/lean_extensions.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  State<PasswordGeneratorScreen> createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _value = Random().nextString();
                });
              },
              child: Text(context.l10n.generate),
            ),
            Card(child: SelectableText(_value)),
          ],
        ),
      ),
    );
  }
}
