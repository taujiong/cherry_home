import 'package:flutter/material.dart';

import 'models/module_meta.dart';
import 'utils/context.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildModuleCard(BuildContext context, ModuleMeta meta) {
    return GestureDetector(
      key: ValueKey(meta.id),
      onTap: () => context.pushPage(builder: (context) => meta.entryPage),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(meta.name),
              subtitle: Text(meta.category),
            ),
            ListTile(
              title: Text(meta.description),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('樱桃屋'),
        elevation: 2,
        scrolledUnderElevation: 4,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 4),
        itemCount: moduleMetas.length,
        itemBuilder: (context, index) =>
            _buildModuleCard(context, moduleMetas[index]),
      ),
    );
  }
}
