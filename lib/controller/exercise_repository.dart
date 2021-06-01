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
  // int? _unnamedExerciseIndex;

  Exercise? selectedExercise;

  List<Exercise> getExercises() => exerciseList;

  Future<void> fetchAndSetData() async {
    final dataList = await dbHelper.getDataForRepo(table);
    List<Exercise> convertedList = dataList
        .map<Exercise>(
          (item) => Exercise(
            item['id'], item['totalCount'], item['name'],
            // id: item['id'],
            // name: item['title'],
            // totalCount: item['totalCount'],
            // countForSets: item['countForSets'],
            // targets: item['targets'],
            // equipment: item['equipment'],
            // notes: item['notes'],
            // resistance: item['resistance'],
            // steps: item['steps'],
            // style: item['style'],
          ),
        )
        .toList();
    exerciseList = convertedList;
    notifyListeners();
  }

  Future<void> addNewExercise(Map<String, dynamic> e) async {
    final Database dB = await dbHelper.database;
    // final Exercise x = Exercise.fromMap(e);
    // x.name = e.values.singleWhere((element) => e.containsKey('name') == true);
    // print('${x.name}');
    // print('${x.runtimeType}');

    await dB.insert(table, e);
    await fetchAndSetData();

    /////////////////
    print(exerciseList);
  }

  void selectExercise(Exercise e) {
    selectedExercise = e;
    notifyListeners();
  }

  void updateSelectedExerciseName(String e) {
    if (e == selectedExercise?.name || e == '') return;
    Exercise thisExercise =
        Exercise(selectedExercise!.id, selectedExercise!.totalCount, e);
    dbHelper.update(thisExercise, table);
    selectExercise(thisExercise);
    notifyListeners();
  }

  void removeExerciseUpdateView(Exercise e) {
    //  exercisesBox.deleteAt(e.index);

    notifyListeners();
  }

  // String _userSkippedName(int? id) {
  //   if (id == null)
  //     _unnamedExerciseIndex = 1;
  //   else {
  //     _unnamedExerciseIndex = id + 1;
  //   }
  //   notifyListeners();
  //   String onComplete = 'Unnamed Exercise #${_unnamedExerciseIndex!}';
  //   return onComplete;
  // }

  Future<void> incrementExerciseCount(Exercise e, int bump) async {
    if (e.id != selectedExercise!.id) return;
    int i = selectedExercise!.totalCount! + bump;

    Exercise thisExercise =
        Exercise(selectedExercise!.id, i, selectedExercise!.name);
    await dbHelper.update(thisExercise, table);
    notifyListeners();
  }

  Future<void> deleteExerciseList() async {
    dbHelper.dropDB();
    notifyListeners();
  }
}
