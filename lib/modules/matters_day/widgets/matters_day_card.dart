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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Colors.blue,
              ),
              child: Text(
                day.description,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Theme.of(context).colorScheme.background,
                child: Text(
                  day.leftDaysFromNow.toString(),
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                "目标日：${DateFormat('yyyy-MM-dd E', 'zh').format(day.targetDate)}",
                style: TextStyle(color: Colors.grey.shade700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
