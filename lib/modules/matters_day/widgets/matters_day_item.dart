import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/context.dart';
import '../models/matters_day.dart';
import '../pages/detail.dart';
import '../pages/modify.dart';
import 'matters_day_card.dart';

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
              context.popPage();
            },
            isDestructiveAction: true,
            child: const Text('删除'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => context.popPage(),
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
            context.popPage();
            context.pushPage(
              builder: (context) => MattersDayModifyPage(
                dayRef: daySnapshot.reference,
              ),
            );
          },
          trailingIcon: Icons.edit,
          child: const Text('编辑'),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            context.popPage();
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
          child: MattersDayCard(
            height: 280,
            daySnapshot: daySnapshot,
            delayedImage: MattersDay.tryLoadBackgroundImage(daySnapshot.id),
          ),
        );
      },
      child: GestureDetector(
        onTap: () => context.pushPage(
          builder: (context) => MattersDayDatailPage(daySnapshot: daySnapshot),
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
                      color: context.getColorScheme().primary,
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
                        color: context.getColorScheme().secondary,
                      ),
                      child: Text(
                        '天',
                        style: context.getTextTheme().bodyLarge!.copyWith(
                              color: context.getColorScheme().onSecondary,
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
