import 'package:flutter/material.dart';

class DaysMatterPage extends StatefulWidget {
  static const String routeName = '/days-matter';

  const DaysMatterPage({super.key});

  @override
  State<DaysMatterPage> createState() => _DaysMatterPageState();
}

class _DaysMatterPageState extends State<DaysMatterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倒数日'),
      ),
      body: const Center(
        child: Text('倒数日'),
      ),
    );
  }
}
