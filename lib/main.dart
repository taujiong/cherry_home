import 'package:cherry_home/home.dart';
import 'package:cherry_home/modules/counter/entry.dart';
import 'package:cherry_home/modules/days-matter/entry.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '樱桃屋',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
      routes: {
        DaysMatterPage.routeName: (context) => const DaysMatterPage(),
        CounterPage.routeName: (context) => const CounterPage(),
      },
    );
  }
}
