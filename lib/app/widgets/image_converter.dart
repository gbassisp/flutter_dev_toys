import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/extensions/platform.dart';
import 'package:flutter_dev_toys/app/extensions/widget.dart';
import 'package:flutter_dev_toys/app/widgets/toy_card.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class ImageConverter extends StatefulWidget {
  const ImageConverter({super.key});

  @override
  State<ImageConverter> createState() => _ImageConverterState();
}

class _ImageConverterState extends State<ImageConverter> {
  final Set<img.Image> _images = {};

  Future<void> _loadImages() async {
    log('loading');
    final files = await ImagePicker().pickMultiImage();
    log('reading');
    final bytes = await Future.wait(files.map((e) => e.readAsBytes()));
    log('decoding');
    final images =
        await Future.wait(bytes.map((e) async => img.decodeImage(e)));
    setState(() {
      _images.addAll(images.whereNotNull());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToyCard(
      title: context.l10n.imageConverter,
      child: Column(
        children: [
          Card(
            child: DropTarget(
              child: TextButton(
                onPressed: _loadImages,
                child: Text(context.l10n.loadImages),
              ),
            ),
          ),
          Wrap(children: _images.map((e) => _ImageCard(image: e)).toList()),
        ],
      ),
    );
  }
}

typedef Bytes = Uint8List;

class _ImageCard extends StatelessWidget {
  const _ImageCard({required this.image});

  final img.Image image;

  Widget get thumbnail =>
      Image.memory(png, fit: BoxFit.contain).constrained(max: 200);

  Bytes get png => img.encodePng(image);
  XFile get pngFile => XFile.fromData(png, mimeType: 'image/png');

  Future<void> saveFiles(BuildContext context) async {
    try {
      if (kIsWeb || platform.isDesktop) {
        await download();
      } else {
        await share();
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackMessage(
          context.l10n.somethingWentWrongWithMessage(
            e.toString(),
          ),
        );
      }
    }
  }

  Future<void> share() async {
    await Share.shareXFiles([pngFile]);
  }

  Future<void> download() async {
    await FileSaver.instance.saveFile(name: 'test123.png', bytes: png);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: thumbnail,
      trailing: IconButton(
        icon: const Icon(Icons.file_download_rounded),
        onPressed: () => saveFiles(context),
      ),
    );
  }
}
