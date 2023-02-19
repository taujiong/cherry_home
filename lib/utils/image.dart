import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<Color> getTextColorOnImage(ImageProvider image) async {
  final palette = await PaletteGenerator.fromImageProvider(image);
  final mainColor = palette.dominantColor ?? palette.paletteColors[0];
  final brightness = ThemeData.estimateBrightnessForColor(mainColor.color);

  return brightness == Brightness.dark ? Colors.white : Colors.black;
}
