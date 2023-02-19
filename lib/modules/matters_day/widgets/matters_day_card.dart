import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/matters_day.dart';

class MattersDayCard extends StatelessWidget {
  final double height;
  final MattersDay day;

  const MattersDayCard({
    super.key,
    required this.height,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 48,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                "${day.description}${day.isExpired ? '已经' : '还有'}",
                style: Theme.of(context).primaryTextTheme.bodyLarge,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  day.leftDaysFromNow.abs().toString(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 96,
                      ),
                ),
              ),
            ),
            Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
              child: Text(
                "${day.isExpired ? '起始日' : '目标日'}："
                "${DateFormat('yyyy-MM-dd E', 'zh').format(day.targetDate)}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
