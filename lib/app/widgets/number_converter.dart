import 'package:english_numerals/english_numerals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/widgets/single_focus_text.dart';
import 'package:flutter_dev_toys/app/widgets/toy_card.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';
import 'package:lean_extensions/lean_extensions.dart';

class NumberConverter extends StatefulWidget {
  const NumberConverter({super.key});

  @override
  State<NumberConverter> createState() => _NumberConverterState();
}

class _NumberConverterState extends State<NumberConverter> {
  BigInt _value = BigInt.zero;
  String? get _cardinal {
    try {
      return Cardinal(_value).enUk;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ToyCard(
      title: context.l10n.numberConverter,
      child: Form(
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
            Card(
              child: ListTile(
                title: Text(context.l10n.cardinal),
                subtitle: FocusTextFormField(
                  text: _cardinal ?? context.l10n.invalidValue,
                  validator: (String? value) {
                    try {
                      final _ = Cardinal(value).toBigInt();
                    } catch (_) {
                      return context.l10n.invalidValue;
                    }

                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      final converted = Cardinal(value).toBigInt();
                      _value = converted;
                    });
                  },
                ),
              ),
            ),
          ],
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
  // getters
  String get _value => widget.number.toRadixExtended(widget.radix);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(context.l10n.radix(widget.radix)),
        subtitle: FocusTextFormField(
          text: _value,
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
        ),
      ),
    );
  }
}
