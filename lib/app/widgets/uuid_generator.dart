
import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/widgets/components.dart';
import 'package:flutter_dev_toys/app/widgets/copiable_text.dart';
import 'package:flutter_dev_toys/app/widgets/toy_card.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';
import 'package:uuid/uuid.dart';

class UUIDGeneratorScreen extends StatefulWidget {
  const UUIDGeneratorScreen({super.key});

  @override
  State<UUIDGeneratorScreen> createState() => _UUIDGeneratorScreenState();
}

class _UUIDGeneratorScreenState extends StringState<UUIDGeneratorScreen> {
  late String _uuid4 = initial;
  late String _uuid1 = initial;

  void _regen() {
    setState(() {
      const uuid = Uuid();
      _uuid1 = uuid.v1();
      _uuid4 = uuid.v4();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToyCard(
      title: context.l10n.uuidGenerator,
      child: Column(
        children: [
          ListTile(
            title: Wrap(
              children: [
                CopiableText(
                  label: context.l10n.uuidV1,
                  text: _uuid1,
                ),
                CopiableText(
                  label: context.l10n.uuidV4,
                  text: _uuid4,
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: _regen,
              child: Text(context.l10n.generate),
            ),
          ),
        ],
      ),
    );
  }
}
