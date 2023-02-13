import 'package:cherry_home/modules/matters_day/pages/add.dart';
import 'package:flutter/material.dart';

import '../models/matters_day.dart';
import '../models/matters_day_repo.dart';

class MattersDayListPage extends StatefulWidget {
  const MattersDayListPage({super.key});

  @override
  State<MattersDayListPage> createState() => _MattersDayListPageState();
}

class _MattersDayListPageState extends State<MattersDayListPage> {
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
    );
  }

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
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) => const MattersDayAddPage(),
                  ))
                  .then((value) => setState(() {}));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
          future: mattersDayRepo.fetchDays(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              snapshot.data!.sort(
                  (a, b) => b.leftDaysFromNow.compareTo(a.leftDaysFromNow));
              return ListView(
                padding: const EdgeInsets.only(top: 4),
                children: snapshot.data!
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
