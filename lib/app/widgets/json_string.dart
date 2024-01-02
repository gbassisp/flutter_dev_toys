import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/widgets/components.dart';
import 'package:flutter_dev_toys/app/widgets/copiable_text.dart';
import 'package:flutter_dev_toys/app/widgets/single_focus_text.dart';
import 'package:flutter_dev_toys/app/widgets/toy_card.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';
import 'package:lean_extensions/lean_extensions.dart';

class JsonStringConverter extends StatefulWidget {
  const JsonStringConverter({super.key});

  @override
  State<JsonStringConverter> createState() => _JsonStringConverterState();
}

class _JsonStringConverterState extends StringState<JsonStringConverter> {
  late String _encoded = initial;
  String get _decoded {
    try {
      return jsonDecode(_encoded).toString();
    } catch (_) {
      return '';
    }
  }

  bool _valid(dynamic decoded) {
    try {
      final encoded = jsonEncode(decoded);
      final d = jsonDecode(encoded);
      const c = DeepCollectionEquality.unordered();
      return decoded is! String &&
          (decoded is Iterable && decoded.isNotEmpty ||
              decoded is Map && decoded.isNotEmpty) &&
          c.equals(d, decoded);
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ToyCard(
      title: context.l10n.jsonStringEncoding,
      child: Wrap(
        children: [
          ListTile(
            title: Text(context.l10n.decoded),
            subtitle: FocusWidget(
              focused: TextFormField(
                initialValue: _decoded,
                validator: (value) {
                  try {
                    if (_valid(value)) {
                      final _ = jsonEncode(value.orEmpty);
                      return null;
                    }
                    return context.l10n.invalidValue;
                  } catch (_) {
                    return context.l10n.invalidValue;
                  }
                },
                onChanged: (value) => setState(() {
                  _encoded = jsonEncode(value);
                }),
              ),
              unfocused: CopiableText(
                text: _decoded,
              ),
            ),
          ),
          ListTile(
            title: Text(context.l10n.encoded),
            subtitle: FocusWidget(
              focused: TextFormField(
                initialValue: _encoded,
                validator: (value) {
                  try {
                    final d = jsonDecode(value.orEmpty);
                    if (_valid(d)) {
                      return null;
                    }
                    return context.l10n.invalidValue;
                  } catch (_) {
                    return context.l10n.invalidValue;
                  }
                },
                onChanged: (value) => setState(() {
                  _encoded = value;
                }),
              ),
              unfocused: CopiableText(
                text: _encoded,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
