import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/extensions/widget.dart';
import 'package:flutter_dev_toys/app/widgets/components.dart';
import 'package:flutter_dev_toys/app/widgets/copiable_text.dart';
import 'package:flutter_dev_toys/app/widgets/single_focus_text.dart';
import 'package:flutter_dev_toys/app/widgets/toy_card.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrCodeGenerator extends StatefulWidget {
  const QrCodeGenerator({super.key});

  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends StringState<QrCodeGenerator> {
  final key = UniqueKey();
  late String _value = initial;

  void _setText(String value) {
    setState(() => _value = value);
  }

  @override
  Widget build(BuildContext context) {
    return ToyCard(
      title: context.l10n.qrCode,
      child: Column(
        children: [
          FocusWidget(
            focused: TextFormField(
              initialValue: _value,
              autofocus: true,
              onChanged: _setText,
            ),
            unfocused: CopiableText(text: _value),
          ),
          if (_value.isNotEmpty)
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: PrettyQrView.data(
                  data: _value,
                  errorCorrectLevel: 3,
                ).constrained(max: 200),
              ),
            ),
        ],
      ),
    );
  }
}
