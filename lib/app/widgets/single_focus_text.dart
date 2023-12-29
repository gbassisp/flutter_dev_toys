import 'package:flutter/material.dart';

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
    return Focus(
      key: _key,
      focusNode: _focus,
      child: _hasFocus ? widget.focused : widget.unfocused,
    );
  }
}
