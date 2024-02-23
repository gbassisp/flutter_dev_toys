import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/extensions/media.dart';
import 'package:flutter_dev_toys/app/extensions/widget.dart';
import 'package:flutter_dev_toys/app/widgets/hasher.dart';
import 'package:flutter_dev_toys/app/widgets/image_converter.dart';
import 'package:flutter_dev_toys/app/widgets/number_converter.dart';
import 'package:flutter_dev_toys/app/widgets/password_generator.dart';
import 'package:flutter_dev_toys/app/widgets/qr_code.dart';
import 'package:flutter_dev_toys/app/widgets/url_encode.dart';
import 'package:flutter_dev_toys/app/widgets/uuid_generator.dart';
import 'package:flutter_dev_toys/config.dart';
import 'package:flutter_dev_toys/gen/assets.gen.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  onPressed: () => launchUrl(githubUri),
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: Text(context.l10n.github),
                ),
                IconButton(
                  onPressed: () => showAboutDialog(
                    context: context,
                    applicationIcon:
                        Assets.images.settings.image().constrained(max: 50),
                    children: [
                      Text(context.l10n.foss),
                      TextButton(
                        onPressed: () => launchUrl(privacyPolicyUri),
                        child: Text(context.l10n.privacyPolicy),
                      ),
                    ],
                  ),
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
                      UUIDGeneratorScreen(),
                      QrCodeGenerator(),
                      UrlEncoder(),
                      NumberConverter(),
                      HasherWidget(),
                      ImageConverter(),
                      // JsonStringConverter(),
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
