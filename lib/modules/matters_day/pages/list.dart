import 'package:flutter/material.dart';

import '../models/matters_day.dart';
import '../widgets/matters_day_item.dart';
import 'add.dart';

class MattersDayListPage extends StatelessWidget {
  final _dayCollectionRef = MattersDay.collectionRef;

  MattersDayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倒数日'),
        elevation: 2,
        scrolledUnderElevation: 4,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MattersDayAddPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _dayCollectionRef
            .orderBy('targetDate', descending: true)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final days = snapshot.data!.docs;
            return ListView.builder(
              padding: const EdgeInsets.only(top: 4),
              itemCount: days.length,
              itemBuilder: (context, index) {
                final daySnapshot = days[index];
                return MattersDayItem(
                  key: ValueKey(daySnapshot.id),
                  daySnapshot: daySnapshot,
                );
              },
            );
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
