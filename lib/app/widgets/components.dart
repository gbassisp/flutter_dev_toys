import 'package:flutter/material.dart';

abstract class StringState<T extends StatefulWidget> extends State<T> {
  @protected
  String initial = '';
}
