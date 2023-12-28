import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/widgets/password_generator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            PasswordGeneratorScreen(),
          ],
        ),
      ),
    );
  }
}
