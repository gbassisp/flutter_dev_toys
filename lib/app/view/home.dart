import 'package:flutter/material.dart';
import 'package:flutter_dev_toys/app/widgets/number_converter.dart';
import 'package:flutter_dev_toys/app/widgets/password_generator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const SingleChildScrollView(
          child: FocusScope(
            child: Wrap(
              children: [
                PasswordGeneratorScreen(),
                NumberConverter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
