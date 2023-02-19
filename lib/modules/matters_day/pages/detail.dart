import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/matters_day.dart';
import '../widgets/matters_day_card.dart';
import 'modify.dart';

class MattersDayDatailPage extends StatelessWidget {
  final QueryDocumentSnapshot<MattersDay> daySnapshot;

  const MattersDayDatailPage({super.key, required this.daySnapshot});

  @override
  Widget build(BuildContext context) {
    final day = daySnapshot.data();

    return Scaffold(
      appBar: AppBar(
        title: const Text('倒数日'),
        elevation: 2,
        scrolledUnderElevation: 4,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    MattersDayModifyPage(dayRef: daySnapshot.reference),
              ),
            ),
            child: Text(
              '编辑',
              style: Theme.of(context).textTheme.bodyLarge!,
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
                MattersDayCard(height: maxHeight * 0.36, day: day),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton.icon(
                      onPressed: () {},
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
