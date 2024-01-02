import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/extensions/media.dart';
import 'package:flutter_dev_toys/app/widgets/hasher.dart';
import 'package:flutter_dev_toys/app/widgets/json_string.dart';
import 'package:flutter_dev_toys/app/widgets/number_converter.dart';
import 'package:flutter_dev_toys/app/widgets/password_generator.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final compact = MediaQuery.of(context).isCompact;
        final density = compact
            ? VisualDensity.compact
            : FlexColorScheme.comfortablePlatformDensity;
        return Theme(
          data: Theme.of(context).copyWith(visualDensity: density),
          child: Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.appName),
              actions: [
                FilledButton.tonalIcon(
                  onPressed: () {},
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: Text(context.l10n.github),
                ),
                IconButton(
                  onPressed: () => showAboutDialog(context: context),
                  icon: const Icon(Icons.info_outline_rounded),
                ),
              ],
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: const SingleChildScrollView(
                child: FocusScope(
                  autofocus: true,
                  child: Wrap(
                    children: [
                      PasswordGeneratorScreen(),
                      NumberConverter(),
                      HasherWidget(),
                      JsonStringConverter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
