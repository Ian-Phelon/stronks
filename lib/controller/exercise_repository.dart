import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model.dart' show Exercise;
import '../controller/controller.dart'
    show DataHelper, ExerciseHelper, ExerciseKeys;

const String exerciseTable = 'exercise';

final _dbHelper = DataHelper();

class ExerciseRepository extends ChangeNotifier {
  ExerciseRepository._();
  // {
  //   fetchAndSetExerciseTableData();
  // }
  static final ExerciseRepository _exerciseRepo = ExerciseRepository._();
  factory ExerciseRepository() => _exerciseRepo;
  static final ExerciseHelper _eHelper = ExerciseHelper();
  static ExerciseRepository get instance => _exerciseRepo;
  static ExerciseRepository of(BuildContext context) {
    return Provider.of<ExerciseRepository>(context, listen: false);
  }

  Future<void> initialize() async {
    await fetchAndSetExerciseTableData();
  }

  static late List<Exercise> exerciseList;

  Exercise selectedExercise = Exercise();

  List<Exercise> getExercises() {
    // fetchAndSetExerciseTableData();
    return exerciseList;
  }

  /// Provides a Size based on String length and Font Styling IAN: this doesn't
  /// belong here. get over it and make another provider, its why we wrapped the
  /// app in a multiprovider
  Size sizeFromText(BuildContext context, String text) {
    text += '______';
    return (TextPainter(
      text: TextSpan(text: text, style: Theme.of(context).textTheme.headline6),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;
  }

  Future<void> fetchAndSetExerciseTableData() async {
    final dataList = await _dbHelper.getDataForRepo(exerciseTable);
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
    print('!!!!!!!!FETCH AND SET EXERCISE TABLE COMPLETE!!!!!!!!');
  }

  Future<void> addToExerciseList(Map<String, dynamic> e) async {
    final Database dB = await _dbHelper.database;
    e.update(
      'name',
      (value) => value == '' ? _userSkippedName() : value,
    );
    await dB.transaction((txn) => txn.insert(exerciseTable, e));
    await fetchAndSetExerciseTableData();
    notifyListeners();
  }

  void selectExercise(Exercise e) {
    selectedExercise = e;
    print('Selected: $selectedExercise');
    notifyListeners();
  }

  Future<void> removeExerciseFromDB(Exercise e) async {
    await _dbHelper.delete(e.id!, exerciseTable);
    getExercises();
    notifyListeners();
  }

  Future<void> updateSelectedExerciseName(String e) async {
    if (e == selectedExercise.name || e == '') return;
    Exercise thisExercise = selectedExercise.copyWith(name: e);
    await _dbHelper.update(thisExercise.toMap(), exerciseTable);
    selectExercise(thisExercise);
    notifyListeners();
  }

  Future<void> incrementExerciseCount(Exercise e, int bump) async {
    if (e.id != selectedExercise.id) {
      return;
    }
    int i = selectedExercise.totalCount! + bump;
    Exercise thisExercise = e.copyWith(totalCount: i);
    await _dbHelper.update(thisExercise.toMap(), exerciseTable);
    selectExercise(thisExercise);
    notifyListeners();
  }

  Future<void> updateGeneral(Exercise e) async {
    // final Database dB = await _dbHelper.database;

    // await dB.transaction((txn) => txn.update(exerciseTable, e.toMap()));
    await _dbHelper.update(e.toMap(), exerciseTable);
    selectExercise(e);
    await fetchAndSetExerciseTableData();
    notifyListeners();
  }

  /// aka user is lazy
  String _userSkippedName() {
    int len = exerciseList.length + 1;
    String onComplete = 'Unnamed Exercise #$len';
    return onComplete;
  }

  /// Like it's hot
  Future<void> dropDB() async {
    _dbHelper.dropDB();
    notifyListeners();
  }

  /// Wrapper for widget access to user input
  Map<String, bool> eAspectForView({required String? input}) =>
      _eHelper.eAspectForView(
        aspect: input ?? 'none',
      );

  /// Wrapper for providing data we can actually store
  String eAspectToStringBuilder(Map<String, bool> aspectFromUser) =>
      _eHelper.eAspectToString(aspectFromUser);

  /// Access a list of strings for common use
  final List<String> syleKeys = ExerciseKeys.ekeys.style;
  final List<String> targetKeys = ExerciseKeys.ekeys.targets;
  final List<String> equipKeys = ExerciseKeys.ekeys.equip;
}
