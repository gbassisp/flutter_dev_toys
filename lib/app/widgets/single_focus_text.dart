import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/widgets/copiable_text.dart';

class FocusWidget extends StatefulWidget {
  const FocusWidget({
    required this.focused,
    required this.unfocused,
    super.key,
  });
  final Widget focused;
  final Widget unfocused;

  @override
  State<FocusWidget> createState() => _FocusWidgetState();
}

class _FocusWidgetState extends State<FocusWidget> {
  final _key = UniqueKey();

  // finals
  final _focus = FocusNode();

  // mutables
  bool _hasFocus = false;

  void _setFocus() {
    setState(() {
      final hasFocus = _focus.hasFocus;
      final hasPrimary = _focus.hasPrimaryFocus;

      if (_hasFocus != hasFocus) {
        _hasFocus = hasFocus;
      }

      if (hasFocus && hasPrimary) {
        _focus.nextFocus();
      }

      for (final f in _focus.children) {
        if (f.hasPrimaryFocus) {
          _focus.unfocus();
          f.requestFocus();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_setFocus);
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(_focus.children.length < 2, 'only 1 focusable child is allowed');

    return Focus(
      key: _key,
      focusNode: _focus,
      autofocus: true,
      canRequestFocus: false,
      child: _hasFocus ? widget.focused : widget.unfocused,
    );
  }
}

class FocusTextFormField extends StatelessWidget {
  const FocusTextFormField({
    required this.text,
    this.onChanged,
    this.validator,
    super.key,
  });
  final String text;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      focused: TextFormField(
        initialValue: text,
        autofocus: true,
        onChanged: onChanged,
        validator: validator,
      ),
      unfocused: CopiableText(text: text),
    );
  }
}
