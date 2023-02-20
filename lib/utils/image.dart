import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;

Future<Image> resolveFromImageProvider(ImageProvider image) {
  final stream = image.resolve(ImageConfiguration.empty);
  final imageCompleter = Completer<Image>();
  late ImageStreamListener listener;
  listener = ImageStreamListener((ImageInfo info, bool synchronousCall) {
    stream.removeListener(listener);
    imageCompleter.complete(info.image);
  });

  stream.addListener(listener);
  return imageCompleter.future;
}

Color? _getMainColor(ByteData imageData, int width, int height) {
  final int rowStride = width * 4;
  final colorMap = <Color, int>{};
  for (int row = 0; row < height; ++row) {
    for (int col = 0; col < width; ++col) {
      final int position = row * rowStride + col * 4;
      final int pixel = imageData.getUint32(position);
      final color = Color((pixel << 24) | (pixel >> 8));
      if (colorMap[color] == null) {
        colorMap[color] = 1;
      } else {
        colorMap[color] = colorMap[color]! + 1;
      }
    }
  }

  Color? mainColor;
  int count = 0;
  for (final entry in colorMap.entries) {
    if (entry.value > count) {
      mainColor = entry.key;
      count = entry.value;
    }
  }
  return mainColor;
}

Future<Color?> getMainColorFromImage(ImageProvider imageProvider) async {
  final image = await resolveFromImageProvider(imageProvider);
  final imageData = await image.toByteData();
  final width = image.width, height = image.height;

  return Isolate.run(() => _getMainColor(imageData!, width, height));
}

Future<Color> getTextColorOnImage(ImageProvider imageProvider) async {
  final mainColor = await getMainColorFromImage(imageProvider);
  if (mainColor == null) return Colors.white;

  final brightness = ThemeData.estimateBrightnessForColor(mainColor);
  return brightness == Brightness.dark ? Colors.white : Colors.black;
}
