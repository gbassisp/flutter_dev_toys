import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/widgets/components.dart';
import 'package:flutter_dev_toys/app/widgets/copiable_text.dart';
import 'package:flutter_dev_toys/app/widgets/toy_card.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';
import 'package:lean_extensions/lean_extensions.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  State<PasswordGeneratorScreen> createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState
    extends StringState<PasswordGeneratorScreen> {
  late String _value = initial;
  int _size = 50;
  final _max = 100;
  final _min = 6;
  late final _count = _max - _min + 1;

  void _regen() {
    setState(() {
      _value = Random().nextString(_size);
    });
  }

  void _setSize(num length) {
    setState(() {
      final n = length.toInt();
      if (n != _size) {
        _size = n;
        _regen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToyCard(
      title: context.l10n.passwordGenerator,
      child: Column(
        children: [
          CopiableText(text: _value),
          ListTile(
            title: ListTile(
              title: Slider.adaptive(
                onChanged: _setSize,
                value: _size.toDouble(),
                label: context.l10n.length(_size),
                divisions: _count,
                min: _min.toDouble(),
                max: _max.toDouble(),
              ),
              trailing: Text(_size.toString()),
            ),
            trailing: ElevatedButton(
              onPressed: _regen,
              child: Text(context.l10n.generate),
            ),
          ),
        ],
      ),
    );
  }
}
