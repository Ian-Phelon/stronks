import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../controller/controller.dart' show DataHelper;
import '../model/model.dart' show Performance;

final _dbHelper = DataHelper();
const String performanceTable = 'performance';

class StatsHelper extends ChangeNotifier {
  StatsHelper._();

  static final StatsHelper _statsHelper = StatsHelper._();
  factory StatsHelper() => _statsHelper;
  static StatsHelper get instance => _statsHelper;

  static StatsHelper of(BuildContext context) {
    return Provider.of<StatsHelper>(context, listen: false);
  }

  Future<void> initialize() async {
    await fetchAndSetPerformanceTableData();
  }

  static late List<Performance> performanceList;
  List<Performance> getPerformanceList() => performanceList;

  List<int> performanceCounts = [0, 0, 0, 0, 0, 0];

  /// [0]: totalCount, [1]: arms, [2]: chest, [3]: back, [4]: core, [5]: legs
  List<int> getPerformanceCounts() {
    fetchAndSetPerformanceTableData();
    return performanceCounts;
  }

  Future<void> addPerformance(Map<String, dynamic> input) async {
    final Database dB = await _dbHelper.database;
    await dB.transaction((txn) => txn.insert(performanceTable, input));
    fetchAndSetPerformanceTableData();
  }

  Future<void> fetchAndSetPerformanceTableData() async {
    final dataList = await _dbHelper.getDataForRepo(performanceTable);
    List<Performance> convertedList = dataList
        .map<Performance>(
          (item) => Performance(
            id: item['id'],
            exerciseId: item['exerciseId'],
            datePerformed: item['datePerformed'],
            updatedCount: item['updatedCount'],
            currentResistance: item['currentResistance'],
            repsOrHold: item['repsOrHold'],
            splitMultiplier: item['splitMultiplier'],
            currentTargets: item['currentTargets'],
          ),
        )
        .toList();
    performanceList = convertedList;
    notifyListeners();
    performanceCounts.clear();
    innerInitialize();
  }

  void innerInitialize() {
    allExercisesTotalCount();
    allExercisesTotalCountArms();
    allExercisesTotalCountChest();
    allExercisesTotalCountBack();
    allExercisesTotalCountCore();
    allExercisesTotalCountLegs();
  }

  void allExercisesTotalCount() async {
    int totalCount = 0;
    for (var e in performanceList) {
      totalCount += e.updatedCount!;
    }
    performanceCounts.insert(0, totalCount);
  }

  void allExercisesTotalCountArms() {
    int totalCount = 0;
    for (var e in performanceList) {
      if (e.currentTargets!.contains('arms')) totalCount += e.updatedCount!;
    }
    performanceCounts.insert(1, totalCount);
  }

  void allExercisesTotalCountChest() {
    int totalCount = 0;
    for (var e in performanceList) {
      if (e.currentTargets!.contains('chest')) totalCount += e.updatedCount!;
    }
    performanceCounts.insert(2, totalCount);
  }

  void allExercisesTotalCountBack() {
    int totalCount = 0;
    for (var e in performanceList) {
      if (e.currentTargets!.contains('back')) totalCount += e.updatedCount!;
    }
    performanceCounts.insert(3, totalCount);
  }

  void allExercisesTotalCountCore() {
    int totalCount = 0;
    for (var e in performanceList) {
      if (e.currentTargets!.contains('core')) totalCount += e.updatedCount!;
    }
    performanceCounts.insert(4, totalCount);
  }

  void allExercisesTotalCountLegs() {
    int totalCount = 0;
    for (var e in performanceList) {
      if (e.currentTargets!.contains('legs')) totalCount += e.updatedCount!;
    }
    performanceCounts.insert(5, totalCount);
  }

  Future<void> removeFromDB(int id) async {
    await _dbHelper.delete(id, performanceTable);
    fetchAndSetPerformanceTableData();
    getPerformanceList();
    notifyListeners();
  }
}
