import 'package:cherry_home/modules/matters_day/widgets/matters_day_item.dart';
import 'package:flutter/material.dart';

import '../services/matters_day_service.dart';
import 'add.dart';

class MattersDayListPage extends StatelessWidget {
  const MattersDayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    mattersDayService.refreshDays();

    return Scaffold(
      appBar: AppBar(
        title: const Text('倒数日'),
        elevation: 2,
        scrolledUnderElevation: 4,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MattersDayAddPage(),
              ));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: mattersDayService.allMattersDays$,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              snapshot.data!.sort(
                  (a, b) => b.leftDaysFromNow.compareTo(a.leftDaysFromNow));
              return ListView.builder(
                padding: const EdgeInsets.only(top: 4),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final day = snapshot.data![index];
                  return MattersDayItem(
                    key: Key(day.id.toString()),
                    day: day,
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
          })),
    );
  }
}
