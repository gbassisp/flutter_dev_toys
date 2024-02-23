import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/widgets/components.dart';
import 'package:flutter_dev_toys/app/widgets/single_focus_text.dart';
import 'package:flutter_dev_toys/app/widgets/toy_card.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';
import 'package:lean_extensions/lean_extensions.dart';

class UrlEncoder extends StatefulWidget {
  const UrlEncoder({super.key});

  @override
  State<UrlEncoder> createState() => _UrlEncoderState();
}

class _UrlEncoderState extends StringState<UrlEncoder> {
  // decoded value
  late String _value = initial;

  // encoded value
  String get encoded => Uri.encodeComponent(_value);

  // double decoded
  String get decoded => Uri.decodeComponent(encoded);

  @override
  Widget build(BuildContext context) {
    return ToyCard(
      title: context.l10n.urlEncoder,
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Wrap(
          children: [
            Card(
              child: ListTile(
                title: Text(context.l10n.encode),
                subtitle: FocusTextFormField(
                  text: decoded,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(context.l10n.decode),
                subtitle: FocusTextFormField(
                  text: encoded,
                  onChanged: (value) {
                    setState(() {
                      _value = Uri.decodeComponent(value);
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
