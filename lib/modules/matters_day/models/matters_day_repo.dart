import 'package:cherry_home/modules/matters_day/models/matters_day.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MattersDayRepo {
  static const tableName = 'matters_day';
  static const seedData = [
    {'description': '在一起 5 周年', 'targetDate': '2023-01-18 00:00:00.000'},
    {'description': '发工资', 'targetDate': '2023-03-05 00:00:00.000'},
    {'description': '下一个法定节假日', 'targetDate': '2023-04-05 00:00:00.000'},
    {'description': '见丈母娘', 'targetDate': '2023-05-01 00:00:00.000'},
    {'description': '在一起 6 周年', 'targetDate': '2024-01-18 00:00:00.000'},
  ];

  Database? _database;

  Future<Database> get database async {
    final dbDir = await getDatabasesPath();
    const dbName = 'matters_day.db';
    final path = join(dbDir, dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return _database!;
  }

  Future<void> _createDb(Database db, int version) async {
    await db.transaction((txn) async {
      await txn.execute('''CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        targetDate TEXT
      )''');

      for (var day in seedData) {
        await txn.insert(tableName, day);
      }
    });
  }

  Future<List<MattersDay>> fetchDays() async {
    final db = await database;
    final items = await db.query(tableName);
    return items.map((item) => MattersDay.fromMap(item)).toList();
  }

  Future<void> insertDay(MattersDay day) async {
    final db = await database;
    await db.insert(tableName, day.toMap());
  }

  Future<void> updateDay(MattersDay day) async {
    final db = await database;
    await db.update(
      tableName,
      day.toMap(),
      where: 'id = ?',
      whereArgs: [day.id],
    );
  }

  Future<void> deleteDay(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

final mattersDayRepoProvider = Provider((ref) => MattersDayRepo());

final mattersDaysProvider = FutureProvider.autoDispose((ref) {
  final repoProvider = ref.watch(mattersDayRepoProvider);
  return repoProvider.fetchDays();
});
