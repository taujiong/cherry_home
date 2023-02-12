import 'package:flutter/material.dart';

class DaysMatterListPage extends StatelessWidget {
  const DaysMatterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倒数日'),
        elevation: 2,
        scrolledUnderElevation: 4,
      ),
      body: const Center(
        child: Text('倒数日'),
      ),
    );
  }
}
