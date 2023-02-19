import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/context.dart';
import '../models/matters_day.dart';

class MattersDayCard extends StatelessWidget {
  final double height;
  final MattersDay day;
  final ImageProvider? image;
  final Color? textColor;

  const MattersDayCard({
    super.key,
    required this.height,
    required this.day,
    this.image,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final hasBackground = image != null;

    return Card(
      child: Container(
        height: height,
        decoration: hasBackground
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: image!,
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
      ),
    );
  }
}
