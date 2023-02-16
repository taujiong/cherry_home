import 'package:rxdart/subjects.dart';

import '../models/matters_day.dart';
import '../repos/matters_day_repo.dart';

class MattersDayService {
  final mattersDayRepo = MattersDayRepo();
  final allMattersDays$ = PublishSubject<List<MattersDay>>();

  Future<void> refreshDays() async {
    final days = await mattersDayRepo.fetchDays();
    allMattersDays$.add(days);
  }

  Future<void> insertDay(MattersDayCreateOrUpdateDto day) async {
    await mattersDayRepo.insertDay(day);
    refreshDays();
  }

  Future<void> updateDay(int id, MattersDayCreateOrUpdateDto day) async {
    await mattersDayRepo.updateDay(id, day);
    refreshDays();
  }

  Future<void> deleteDay(int id) async {
    await mattersDayRepo.deleteDay(id);
    refreshDays();
  }
}

final mattersDayService = MattersDayService();
