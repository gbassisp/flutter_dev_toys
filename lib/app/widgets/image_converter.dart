import 'dart:developer';
import 'dart:io';
import 'dart:math' hide log;

import 'package:archive/archive.dart';
import 'package:collection/collection.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/extensions/platform.dart';
import 'package:flutter_dev_toys/app/extensions/widget.dart';
import 'package:flutter_dev_toys/app/widgets/toy_card.dart';
import 'package:flutter_dev_toys/l10n/l10n.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:lean_extensions/lean_extensions.dart';
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
      _images
        ..clear()
        ..addAll(images.whereNotNull());
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
          Wrap(children: _images.map((e) => ImageCard(image: e)).toList()),
        ],
      ),
    );
  }
}

typedef Bytes = Uint8List;

class ImageCard extends StatelessWidget {
  const ImageCard({required this.image, super.key});

  final img.Image image;

  Future<void> saveFiles(BuildContext context) async {
    try {
      if (kIsWeb) {
        await download();
      } else if (platform.isDesktop) {
        await save(context);
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
    await Share.shareXFiles([image.xzip]);
  }

  Future<void> download() async {
    await FileSaver.instance.saveFile(name: _filename, bytes: image.zip);
  }

  Future<void> save(BuildContext context) async {
    final path = await FilePicker.platform.saveFile(
      dialogTitle: context.l10n.saveFile,
      fileName: _filename,
    );
    if (path != null) {
      await File(_addExtension(path)).writeAsBytes(image.zip);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: image.thumbnail,
      trailing: IconButton(
        icon: const Icon(Icons.file_download_rounded),
        onPressed: () => saveFiles(context),
      ),
    );
  }
}

const _filename = 'icons.zip';

extension _ImageConverter on img.Image {
  img.Image get image => img.Image.from(this);
  // img.Image get image => img.Image.from(this);
  Widget get thumbnail =>
      Image.memory(png, fit: BoxFit.contain).constrained(max: 200);

  Bytes get png => img.encodePng(image);
  Bytes get jpg => img.encodeJpg(image);
  Bytes get ico => img.encodeIco(image);
  Bytes get bmp => img.encodeBmp(image);
  Iterable<int> get sizes => ({
        20,
        24,
        29,
        40,
        48,
        60,
        72,
        76,
        83,
        120,
        196,
        216,
        ...List.generate(8, (index) => pow(2, index + 4).toInt()),
      }.toArray()
            ..sort())
          .reversed;

  Archive get bundle {
    final b = Archive()
      ..addFile(ArchiveFile('png/image_$height.png', png.lengthInBytes, png))
      ..addFile(ArchiveFile('jpg/image_$height.jpg', jpg.lengthInBytes, jpg))
      ..addFile(ArchiveFile('bmp/image_$height.bmp', bmp.lengthInBytes, bmp));
    // ico limit:
    if (height <= 256) {
      b.addFile(ArchiveFile('ico/image_$height.ico', ico.lengthInBytes, ico));
    }

    return b;
  }

  Bytes get zip {
    final a = Archive();
    for (final s in sizes) {
      final i = img.copyResize(this, height: s, width: s);
      final b = i.bundle;
      log(b.toString());
      for (final f in b) {
        a.addFile(f);
      }
    }

    return ZipEncoder().encode(a)! as Bytes;
  }

  XFile get xzip => XFile.fromData(zip, mimeType: 'application/zip');
}

String _addExtension(String path, [String extension = 'zip']) {
  assert(!extension.startsWith('.'), 'do not add . to file extension');

  final x = '.$extension';
  if (path.endsWith(x)) {
    return path;
  }

  return path + x;
}
