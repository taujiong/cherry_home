import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/matters_day.dart';
import '../pages/add.dart';

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
                builder: (context) => MattersDayAddPage(
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
        return Container(
          width: 500,
          height: 500,
          color: Colors.teal,
          child: Center(
            child: Text(day.description),
          ),
        );
      },
      child: GestureDetector(
        // onTap: ,
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
                      color: Colors.orange,
                      child: Text(
                        '${day.leftDaysFromNow.abs()}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color: Colors.orange[700],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '天',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
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
