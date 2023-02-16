import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/matters_day.dart';
import '../pages/add.dart';
import '../services/matters_day_service.dart';

class MattersDayItem extends StatelessWidget {
  final MattersDay day;

  const MattersDayItem({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: [
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MattersDayAddPage(
                toBeUpdateDay: day,
              ),
            ));
          },
          trailingIcon: Icons.edit,
          child: const Text('编辑'),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            mattersDayService
                .deleteDay(day.id)
                .then((value) => Navigator.of(context).pop());
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
        key: Key(day.id.toString()),
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
