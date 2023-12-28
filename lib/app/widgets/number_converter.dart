import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/widgets/copiable_text.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';
import 'package:lean_extensions/lean_extensions.dart';

class NumberConverter extends StatefulWidget {
  const NumberConverter({super.key});

  @override
  State<NumberConverter> createState() => _NumberConverterState();
}

class _NumberConverterState extends State<NumberConverter> {
  BigInt _value = BigInt.zero;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(context.l10n.numberConverter),
        subtitle: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Wrap(
            children: [
              _ConvertedNumber(
                number: _value,
                onChanged: (number) => setState(() => _value = number),
                radix: 10,
              ),
              _ConvertedNumber(
                number: _value,
                onChanged: (number) => setState(() => _value = number),
                radix: 2,
              ),
              _ConvertedNumber(
                number: _value,
                onChanged: (number) => setState(() => _value = number),
                radix: 8,
              ),
              _ConvertedNumber(
                number: _value,
                onChanged: (number) => setState(() => _value = number),
                radix: 16,
              ),
              _ConvertedNumber(
                number: _value,
                onChanged: (number) => setState(() => _value = number),
                radix: 32,
              ),
              _ConvertedNumber(
                number: _value,
                onChanged: (number) => setState(() => _value = number),
                radix: 62,
              ),
              _ConvertedNumber(
                number: _value,
                onChanged: (number) => setState(() => _value = number),
                radix: 64,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConvertedNumber extends StatefulWidget {
  _ConvertedNumber({
    required this.number,
    required this.onChanged,
    required this.radix,
  }) : super(key: ValueKey(radix));
  final BigInt number;
  final void Function(BigInt number) onChanged;
  final int radix;

  @override
  State<_ConvertedNumber> createState() => _ConvertedNumberState();
}

class _ConvertedNumberState extends State<_ConvertedNumber> {
  final _key = UniqueKey();

  // finals
  final _focus = FocusNode();

  // getters
  String get _value => widget.number.toRadixExtended(widget.radix);

  // mutables
  bool _hasFocus = false;

  void _setFocus(bool hasFocus) {
    if (_hasFocus != hasFocus) {
      setState(() {
        _hasFocus = hasFocus;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      _setFocus(_focus.hasFocus);
    });
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
      child: Card(
        child: ListTile(
          title: Text(context.l10n.radix(widget.radix)),
          subtitle: _hasFocus
              ? TextFormField(
                  initialValue: _value,
                  autofocus: _hasFocus,
                  // onTapOutside: (_) => _focus.unfocus(),
                  // focusNode: _focus,
                  validator: (String? value) {
                    if (value?.tryToBigInt(widget.radix) == null) {
                      return context.l10n.invalidValue;
                    }

                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      final converted = value.toBigInt(widget.radix);
                      widget.onChanged(converted);
                    });
                  },
                )
              : CopiableText(text: _value),
        ),
      ),
    );
  }
}
