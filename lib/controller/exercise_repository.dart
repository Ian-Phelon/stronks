import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model.dart' show Exercise;
import '../controller/controller.dart' as db show DataHelper;

const String table = 'exercise';
final dbHelper = db.DataHelper();

class ExerciseRepository extends ChangeNotifier {
  ExerciseRepository._() {
    fetchAndSetData();
  }
  static final ExerciseRepository _exerciseRepo = ExerciseRepository._();
  factory ExerciseRepository() => _exerciseRepo;

  static late List<Exercise> exerciseList;
  int? _unnamedExerciseIndex;
  int? get unnamedExerciseIndex => this._unnamedExerciseIndex;

  set unnamedExerciseIndex(int? value) => this._unnamedExerciseIndex = value;

  Exercise? selectedExercise;

  List<Exercise> getExercises() {
    fetchAndSetData();
    return exerciseList;
  }

  Future<void> fetchAndSetData() async {
    final dataList = await dbHelper.getDataForRepo(table);
    List<Exercise> convertedList = dataList
        .map<Exercise>(
          (item) => Exercise(
            id: item['id'],
            totalCount: item['totalCount'],
            name: item['name'],
            countForSets: item['countForSets'],
            targets: item['targets'],
            equipment: item['equipment'],
            notes: item['notes'],
            resistance: item['resistance'],
            steps: item['steps'],
            style: item['style'],
          ),
        )
        .toList();
    exerciseList = convertedList;
    notifyListeners();
  }

  Future<void> addNewExercise(Map<String, dynamic> e) async {
    final Database dB = await dbHelper.database;
    Exercise x = Exercise.fromMap(e);
    if (x.name == '' || x.name == null) {
      Exercise y = x.copyWith(
        name: _userSkippedName(unnamedExerciseIndex),
      );
      x = y;
    }

    await dB.insert(table, x.toMap());
    await fetchAndSetData();
  }

  void selectExercise(Exercise e) {
    selectedExercise = e;
    notifyListeners();
  }

  Future<void> updateSelectedExerciseName(String e) async {
    if (e == selectedExercise?.name || e == '') return;
    Exercise thisExercise = Exercise(
        id: selectedExercise!.id,
        totalCount: selectedExercise!.totalCount,
        name: e);
    await dbHelper.update(thisExercise, table);
    selectExercise(thisExercise);
    notifyListeners();
  }

  Future<void> removeExerciseUpdateView(Exercise e) async {
    await dbHelper.delete(e.id!, table);
    notifyListeners();
  }

  Future<void> incrementExerciseCount(Exercise e, int bump) async {
    if (e.id != selectedExercise!.id) return;
    int i = selectedExercise!.totalCount! + bump;

    Exercise thisExercise = e.copyWith(totalCount: i);
    await dbHelper.update(thisExercise, table);
    selectExercise(thisExercise);
    notifyListeners();
  }

  String _userSkippedName(int? id) {
    if (id == null)
      unnamedExerciseIndex = 1;
    else {
      unnamedExerciseIndex = id + 1;
      notifyListeners();
    }
    String onComplete = 'Unnamed Exercise #${_unnamedExerciseIndex!}';
    return onComplete;
  }

  Future<void> dropDB() async {
    dbHelper.dropDB();
    notifyListeners();
  }
}
