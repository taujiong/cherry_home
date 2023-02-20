import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/context.dart';
import '../../../utils/io.dart';
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
  late Future<ImageProvider?> _image;

  @override
  void initState() {
    super.initState();
    _day = widget.daySnapshot.data();
    _image = MattersDay.tryLoadBackgroundImage(widget.daySnapshot.id);
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

  void _saveImageToLocal(String id, XFile pickedImage) async {
    final savePath = await getLocalFilePath(
      MattersDay.groupName,
      MattersDay.backgroundImageDir,
      id,
    );
    final savedFile = File(savePath);
    final exist = await savedFile.exists();
    if (!exist) {
      await savedFile.create(recursive: true);
    }
    await pickedImage.saveTo(savePath);
  }

  void _setBackground() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return null;
    _saveImageToLocal(widget.daySnapshot.id, pickedImage);
    setState(() {
      _image = Future.value(Image.file(File(pickedImage.path)).image);
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
                  delayedImage: _image,
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
