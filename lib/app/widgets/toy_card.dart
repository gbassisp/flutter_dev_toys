import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/extensions/media.dart';

class ToyCard extends StatefulWidget {
  const ToyCard({required this.title, required this.child, super.key});
  final String title;
  final Widget child;

  @override
  State<ToyCard> createState() => _ToyCardState();
}

class _ToyCardState extends State<ToyCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    const up = Icon(Icons.arrow_drop_up_outlined);
    const down = Icon(Icons.arrow_drop_down_outlined);
    final compact = MediaQuery.of(context).isCompact;

    return Card(
      child: ListTile(
        title: ListTile(
          title: Text(widget.title),
          titleTextStyle:
              compact ? null : Theme.of(context).textTheme.headlineSmall,
          trailing: IconButton(
            icon: _expanded ? up : down,
            onPressed: () => setState(() => _expanded = !_expanded),
          ),
        ),
        subtitle: _expanded ? widget.child : null,
      ),
    );
  }
}
