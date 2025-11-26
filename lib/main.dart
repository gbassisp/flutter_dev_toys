import 'package:flutter_dev_toys/app/app.dart';
import 'package:flutter_dev_toys/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
