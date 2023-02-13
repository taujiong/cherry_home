import 'package:flutter/material.dart';

import '../models/matters_day.dart';
import '../models/matters_day_repo.dart';

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
      body: FutureBuilder(
          future: mattersDayRepo.fetchDays(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.only(top: 4),
                children: snapshot.data!
                    .where((day) => !day.isExpired)
                    .map((day) => _buildDayItem(context, day))
                    .toList(),
              );
            }

            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          })),
    );
  }
}
