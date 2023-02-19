import 'package:cherry_home/modules/matters_day/pages/detail.dart';
import 'package:cherry_home/modules/matters_day/widgets/matters_day_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/matters_day.dart';
import '../pages/modify.dart';

class MattersDayItem extends StatelessWidget {
  final QueryDocumentSnapshot<MattersDay> daySnapshot;

  const MattersDayItem({super.key, required this.daySnapshot});

  void _showDeletePopup(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: const Text('这将从你的倒数日列表中删除该项'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              daySnapshot.reference.delete();
              Navigator.of(context).pop();
            },
            isDestructiveAction: true,
            child: const Text('删除'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final day = daySnapshot.data();

    return CupertinoContextMenu(
      actions: [
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MattersDayModifyPage(
                  dayRef: daySnapshot.reference,
                ),
              ),
            );
          },
          trailingIcon: Icons.edit,
          child: const Text('编辑'),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.of(context).pop();
            _showDeletePopup(context);
          },
          isDestructiveAction: true,
          trailingIcon: Icons.delete,
          child: const Text('删除'),
        ),
      ],
      // ignore: deprecated_member_use
      previewBuilder: (context, animation, child) {
        return SingleChildScrollView(
          child: MattersDayCard(height: 280, day: day),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                MattersDayDatailPage(daySnapshot: daySnapshot),
          ),
        ),
        child: Card(
          child: Container(
            height: 36,
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    day.description,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(day.isExpired ? '已过' : '还有'),
                    Container(
                      height: double.infinity,
                      width: 64,
                      margin: const EdgeInsets.only(left: 8),
                      alignment: Alignment.center,
                      color: Theme.of(context).colorScheme.primary,
                      child: Text(
                        '${day.leftDaysFromNow.abs()}',
                        style: Theme.of(context).primaryTextTheme.bodyLarge,
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Text(
                        '天',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
