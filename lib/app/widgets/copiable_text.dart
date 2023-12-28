import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';

class CopiableText extends StatefulWidget {
  CopiableText({required this.text}) : super(key: UniqueKey());

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
    setState(() => _copied = true);
  }

  @override
  Widget build(BuildContext context) {
    const before = Icon(Icons.copy_rounded);
    const after = Icon(Icons.check_rounded);

    return ListTile(
      title: Card(child: SelectableText(_value)),
      trailing: IconButton(
        onPressed: _enabled ? _copyToClipboard : null,
        icon: _copied ? after : before,
        tooltip: context.l10n.copy,
      ),
    );
  }
}
