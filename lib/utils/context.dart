import 'package:flutter/material.dart';

extension Utils on BuildContext {
  ColorScheme getColorScheme() {
    return Theme.of(this).colorScheme;
  }

  TextTheme getTextTheme() {
    return Theme.of(this).textTheme;
  }
}
