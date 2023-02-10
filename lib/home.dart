import 'package:cherry_home/modules/counter/entry.dart';
import 'package:cherry_home/modules/days-matter/entry.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatefulWidget {
  const ModuleCard({
    super.key,
    required this.name,
    required this.category,
    required this.description,
    required this.route,
  });

  final String name;
  final String category;
  final String description;
  final String route;

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        widget.route,
      ),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(widget.name),
              subtitle: Text(widget.category),
            ),
            ListTile(
              title: Text(widget.description),
            )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('樱桃屋')),
      body: ListView(
        children: const [
          ModuleCard(
            name: '倒数日',
            category: '生活',
            description: '倒数日，可以是一项预定的规划，也可以是一份美好的期待',
            route: DaysMatterPage.routeName,
          ),
          ModuleCard(
            name: '计数器',
            category: '工具',
            description: '计数器，记录每一次突破',
            route: CounterPage.routeName,
          ),
        ],
      ),
    );
  }
}
