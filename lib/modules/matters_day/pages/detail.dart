import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../utils/context.dart';
import '../models/matters_day.dart';
import '../widgets/matters_day_card.dart';
import 'modify.dart';

class MattersDayDatailPage extends StatefulWidget {
  final QueryDocumentSnapshot<MattersDay> daySnapshot;

  const MattersDayDatailPage({super.key, required this.daySnapshot});

  @override
  State<MattersDayDatailPage> createState() => _MattersDayDatailPageState();
}

class _MattersDayDatailPageState extends State<MattersDayDatailPage> {
  late MattersDay _day;
  ImageProvider? _image;
  Color? _textColor;

  @override
  void initState() {
    super.initState();
    _day = widget.daySnapshot.data();
  }

  void _editDay() async {
    final updatedDay = await context.pushPage<MattersDay>(
      builder: (context) =>
          MattersDayModifyPage(dayRef: widget.daySnapshot.reference),
    );
    if (updatedDay == null) return;
    setState(() {
      _day = updatedDay;
    });
  }

  void _setBackground() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imageFile == null) return;

    final image = Image.file(File(imageFile.path)).image;
    final palette = await PaletteGenerator.fromImageProvider(image);
    final mainColor = palette.dominantColor ?? palette.paletteColors[0];
    final brightness = ThemeData.estimateBrightnessForColor(mainColor.color);

    setState(() {
      _image = image;
      _textColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倒数日'),
        elevation: 2,
        scrolledUnderElevation: 4,
        actions: [
          TextButton(
            onPressed: _editDay,
            child: Text(
              '编辑',
              style: context.getTextTheme().bodyLarge!,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;

          return Padding(
            padding: EdgeInsets.only(
              top: maxHeight * 0.2,
              left: 24,
              right: 24,
            ),
            child: Column(
              children: [
                MattersDayCard(
                  height: maxHeight * 0.36,
                  day: _day,
                  image: _image,
                  textColor: _textColor,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton.icon(
                      onPressed: _setBackground,
                      icon: const Icon(Icons.image),
                      label: const Text('设置背景'),
                    ),
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                      label: const Text('分享图片'),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
