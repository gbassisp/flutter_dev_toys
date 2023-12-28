import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.password_rounded),
              title: CopiableText(text: _value),
              subtitle: Slider.adaptive(
                onChanged: _setSize,
                value: _size.toDouble(),
                label: context.l10n.length(_size),
                divisions: _count,
                min: _min.toDouble(),
                max: _max.toDouble(),
              ),
              trailing: ElevatedButton(
                onPressed: _regen,
                child: Text(context.l10n.generate),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CopiableText extends StatefulWidget {
  const CopiableText({required this.text, super.key});

  final String text;

  @override
  State<CopiableText> createState() => _CopiableTextState();
}

class _CopiableTextState extends State<CopiableText> {
  String get _value => widget.text;
  bool get _enabled => _value.isNotEmpty;
  bool _copied = false;

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: _value));
    setState(() {
      _copied = true;
    });
  }

  final _before = const Icon(Icons.copy_rounded);
  final _after = const Icon(Icons.paste_rounded);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Card(child: SelectableText(_value)),
      trailing: IconButton(
        onPressed: _enabled ? _copyToClipboard : null,
        icon: _copied ? _after : _before,
        tooltip: context.l10n.copy,
      ),
    );
  }
}
