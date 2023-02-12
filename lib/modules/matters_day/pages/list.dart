import 'package:cherry_home/modules/matters_day/models/matters_day_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/matters_day.dart';

class MattersDayListPage extends StatelessWidget {
  const MattersDayListPage({super.key});

  Widget _buildDayItem(BuildContext context, MattersDay day) {
    return GestureDetector(
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
                  const Text('还有'),
                  Container(
                    height: double.infinity,
                    width: 64,
                    margin: const EdgeInsets.only(left: 8),
                    alignment: Alignment.center,
                    color: Colors.orange,
                    child: Text(
                      '${day.leftDaysFromNow}',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倒数日'),
        elevation: 2,
        scrolledUnderElevation: 4,
      ),
      body: Consumer(builder: (_, WidgetRef ref, __) {
        final days = ref.watch(mattersDaysProvider);
        return days.when(
          data: (days) => ListView(
            padding: const EdgeInsets.only(top: 4),
            children: days
                .where((day) => !day.isExpired)
                .map((day) => _buildDayItem(context, day))
                .toList(),
          ),
          error: (error, _) => Text(error.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
