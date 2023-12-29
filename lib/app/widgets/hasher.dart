import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/widgets/components.dart';
import 'package:flutter_dev_toys/app/widgets/copiable_text.dart';
import 'package:flutter_dev_toys/app/widgets/toy_card.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';

/// currently supports converting to:
/// SHA-1
/// SHA-224
/// SHA-256
/// SHA-384
/// SHA-512
/// SHA-512/224
/// SHA-512/256
/// MD5
class HasherWidget extends StatefulWidget {
  const HasherWidget({super.key});

  @override
  State<HasherWidget> createState() => _HasherWidgetState();
}

class _HasherWidgetState extends StringState<HasherWidget> {
  late String _value = initial;
  Uint8List get _bytes => utf8.encode(_value);

  Widget _hash({required String name, required Hash algo}) {
    return ListTile(
      title: Text(name),
      subtitle: CopiableText(text: algo.convert(_bytes).toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ToyCard(
      title: l10n.hashing,
      child: ListTile(
        title: Wrap(
          children: [
            ListTile(
              title: Text(l10n.input),
              subtitle: TextFormField(
                initialValue: _value,
                onChanged: (value) => setState(() => _value = value),
              ),
            ),
            _hash(name: l10n.md5, algo: md5),
            _hash(name: l10n.sha1, algo: sha1),
            _hash(name: l10n.sha224, algo: sha224),
            _hash(name: l10n.sha256, algo: sha256),
            _hash(name: l10n.sha384, algo: sha384),
            _hash(name: l10n.sha512, algo: sha512),
            _hash(name: l10n.sha512224, algo: sha512224),
            _hash(name: l10n.sha512256, algo: sha512256),
          ],
        ),
      ),
    );
  }
}
