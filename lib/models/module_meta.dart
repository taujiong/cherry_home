import 'package:flutter/widgets.dart';

import '../modules/counter/pages/counter.dart';
import '../modules/matters_day/pages/list.dart';

class ModuleMeta {
  final String id;
  final String name;
  final String category;
  final String description;
  final Widget entryPage;

  const ModuleMeta({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.entryPage,
  });
}

List<ModuleMeta> moduleMetas = [
  const ModuleMeta(
    id: 'matters_day',
    name: '倒数日',
    category: '生活',
    description: '倒数日，可以是一项预定的规划，也可以是一份美好的期待',
    entryPage: MattersDayListPage(),
  ),
  const ModuleMeta(
    id: 'counter',
    name: '计数器',
    category: '工具',
    description: '计数器，记录每一次突破',
    entryPage: CounterPage(),
  ),
];
