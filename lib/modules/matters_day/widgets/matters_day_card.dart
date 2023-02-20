import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/context.dart';
import '../../../utils/image.dart';
import '../models/matters_day.dart';

class _ImageInfo {
  final ImageProvider image;
  final Color textColor;

  _ImageInfo({required this.image, required this.textColor});
}

final colorMap = <String, Color>{};

class MattersDayCard extends StatelessWidget {
  final double height;
  final QueryDocumentSnapshot<MattersDay> daySnapshot;
  final Future<ImageProvider?> delayedImage;
  final bool forceUpdateColor;

  const MattersDayCard({
    super.key,
    required this.height,
    required this.daySnapshot,
    required this.delayedImage,
    this.forceUpdateColor = false,
  });

  Future<_ImageInfo?> _loadImageAndColor() async {
    final loadedImage = await delayedImage;
    if (loadedImage == null) return null;

    var color = colorMap[daySnapshot.id];
    if (color == null || forceUpdateColor) {
      color = await getTextColorOnImage(loadedImage);
      colorMap[daySnapshot.id] = color;
    }
    return _ImageInfo(image: loadedImage, textColor: color);
  }

  Widget _buildRealCard(
    BuildContext context,
    ImageProvider? image,
    Color? textColor,
  ) {
    final hasBackground = image != null;
    final day = daySnapshot.data();

    return Container(
      decoration: hasBackground
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            )
          : const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 48,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: hasBackground
                ? const BoxDecoration()
                : BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: context.getColorScheme().primary,
                  ),
            child: Text(
              "${day.description}${day.isExpired ? '已经' : '还有'}",
              style: context.getTextTheme().bodyLarge!.copyWith(
                    color: textColor ?? context.getColorScheme().onPrimary,
                  ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                day.leftDaysFromNow.abs().toString(),
                style: context.getTextTheme().displayLarge!.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 96,
                    ),
              ),
            ),
          ),
          Container(
            height: 48,
            alignment: Alignment.center,
            decoration: hasBackground
                ? const BoxDecoration()
                : BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: context.getColorScheme().surfaceVariant,
                  ),
            child: Text(
              "${day.isExpired ? '起始日' : '目标日'}："
              "${DateFormat('yyyy-MM-dd E', 'zh').format(day.targetDate)}",
              style: TextStyle(
                color: textColor ?? context.getColorScheme().onSurfaceVariant,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: height,
        child: FutureBuilder(
          future: _loadImageAndColor(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            final data = snapshot.data;
            return _buildRealCard(context, data?.image, data?.textColor);
          },
        ),
      ),
    );
  }
}
