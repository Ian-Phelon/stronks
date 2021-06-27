import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

// import '../constants.dart';
import '../model/model.dart' show Exercise;
import '../controller/controller.dart'
    show DataHelper, ExerciseHelper, ExerciseKeys;

const String table = 'exercise';
final _dbHelper = DataHelper();

class ExerciseRepository extends ChangeNotifier {
  ExerciseRepository._() {
    fetchAndSetData();
  }
  static final ExerciseRepository _exerciseRepo = ExerciseRepository._();
  factory ExerciseRepository() => _exerciseRepo;
  static final ExerciseHelper eHelper = ExerciseHelper();

  static late List<Exercise> exerciseList;

  Exercise? selectedExercise;

  List<Exercise> getExercises() {
    fetchAndSetData();
    return exerciseList;
  }

  Future<void> fetchAndSetData() async {
    final dataList = await _dbHelper.getDataForRepo(table);
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

  Future<void> addToExerciseList(Map<String, dynamic> e) async {
    final Database dB = await _dbHelper.database;
    e.update(
      'name',
      (value) => value == '' ? _userSkippedName() : value,
    );

    await dB.insert(table, e);
    await fetchAndSetData();
    print(exerciseList);
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
        name: e,
        style: selectedExercise!.style);
    await _dbHelper.update(thisExercise, table);
    selectExercise(thisExercise);
    notifyListeners();
  }

  Future<void> removeExerciseUpdateView(Exercise e) async {
    await _dbHelper.delete(e.id!, table);
    notifyListeners();
  }

  Future<void> incrementExerciseCount(Exercise e, int bump) async {
    if (e.id != selectedExercise!.id) return;
    int i = selectedExercise!.totalCount! + bump;

    Exercise thisExercise = e.copyWith(totalCount: i);
    await _dbHelper.update(thisExercise, table);
    selectExercise(thisExercise);
    notifyListeners();
  }

  String _userSkippedName() {
    int len = exerciseList.length + 1;
    String onComplete = 'Unnamed Exercise #$len';
    return onComplete;
  }

  Future<void> dropDB() async {
    _dbHelper.dropDB();
    notifyListeners();
  }

  Map<String, bool> eAspectForView({required String? input}) =>
      eHelper.eAspectForView(
        aspect: input ?? 'none',
      );

  String eAspectToStringBuilder(Map<String, bool> aspectFromUser) =>
      eHelper.eAspectToString(aspectFromUser);

  final List<String> syleKeys = ExerciseKeys.ekeys.style;
  final List<String> targetKeys = ExerciseKeys.ekeys.targets;
}
