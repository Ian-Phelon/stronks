import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

// import '../constants.dart';
import '../constants.dart';
import '../model/model.dart' show Exercise, Performance;
import '../controller/controller.dart'
    show DataHelper, ExerciseHelper, ExerciseKeys;

const String exerciseTable = 'exercise';
const String performanceTable = 'performance';
final _dbHelper = DataHelper();

class ExerciseRepository extends ChangeNotifier {
  ExerciseRepository._() {
    fetchAndSetExerciseTableData();
    // fetchAndSetPerformanceTableData();
  }
  static final ExerciseRepository _exerciseRepo = ExerciseRepository._();
  factory ExerciseRepository() => _exerciseRepo;
  static final ExerciseHelper eHelper = ExerciseHelper();

  static late List<Exercise> exerciseList;
  static late List<Performance> performanceList;

  late Exercise? selectedExercise;

  List<Exercise> getExercises() {
    fetchAndSetExerciseTableData();
    return exerciseList;
  }

  List<Performance> getPerformances() {
    fetchAndSetExerciseTableData();
    return performanceList;
  }

  Future<void> addPerformance(Map<String, dynamic> input) async {
    final Database dB = await _dbHelper.database;
    await dB.transaction((txn) => txn.insert(performanceTable, input));
  }

  /// Provides a Size based on String length and Font Styling IAN: this doesn't
  /// belong here. get over it and make another provider, its why we wrapped the
  /// app in a multiprovider
  Size sizeFromText(BuildContext context, String text) {
    text += '______';
    return (TextPainter(
      text: TextSpan(text: text, style: kAspectTextStyle),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;
  }

  int allExercisesTotalCount() {
    int totalCount = 0;
    for (var e in exerciseList) {
      totalCount += e.totalCount!;
    }
    return totalCount;
  }

  int allExercisesTotalCountArms() {
    int totalCount = 0;
    for (var e in exerciseList) {
      Map target = eAspectForView(input: e.targets);
      target.removeWhere(
          (key, value) => !key.toString().startsWith(r'targetArms'));
      bool valid = target.values.any((e) => e == true);
      if (valid) totalCount += e.totalCount!;
    }
    return totalCount;
  }

  int allExercisesTotalCountChest() {
    int totalCount = 0;
    for (var e in exerciseList) {
      Map target = eAspectForView(input: e.targets);
      target.removeWhere(
          (key, value) => !key.toString().startsWith(r'targetChest'));
      bool valid = target.values.any((e) => e == true);
      if (valid) totalCount += e.totalCount!;
    }
    return totalCount;
  }

  int allExercisesTotalCountBack() {
    int totalCount = 0;
    for (var e in exerciseList) {
      Map target = eAspectForView(input: e.targets);
      target.removeWhere(
          (key, value) => !key.toString().startsWith(r'targetBack'));
      bool valid = target.values.any((e) => e == true);
      if (valid) totalCount += e.totalCount!;
    }
    return totalCount;
  }

  int allExercisesTotalCountCore() {
    int totalCount = 0;
    for (var e in exerciseList) {
      Map target = eAspectForView(input: e.targets);
      target.removeWhere(
          (key, value) => !key.toString().startsWith(r'targetCore'));
      bool valid = target.values.any((e) => e == true);
      if (valid) totalCount += e.totalCount!;
    }
    return totalCount;
  }

  int allExercisesTotalCountLegs() {
    int totalCount = 0;
    for (var e in exerciseList) {
      Map target = eAspectForView(input: e.targets);
      target.removeWhere(
          (key, value) => !key.toString().startsWith(r'targetLegs'));
      bool valid = target.values.any((e) => e == true);
      if (valid) totalCount += e.totalCount!;
    }
    return totalCount;
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
  }

  Future<void> addToExerciseList(Map<String, dynamic> e) async {
    final Database dB = await _dbHelper.database;
    e.update(
      'name',
      (value) => value == '' ? _userSkippedName() : value,
    );
    await dB.transaction((txn) => txn.insert(exerciseTable, e));
    await fetchAndSetExerciseTableData();
  }

  void selectExercise(Exercise e) {
    selectedExercise = e;
    notifyListeners();
  }

  Future<void> removeExerciseFromDB(Exercise e) async {
    await _dbHelper.delete(e.id!, exerciseTable);
    getExercises();
    notifyListeners();
  }

  Future<void> updateSelectedExerciseName(String e) async {
    if (e == selectedExercise?.name || e == '') return;
    Exercise thisExercise = selectedExercise!.copyWith(name: e);
    await _dbHelper.update(thisExercise.toMap(), exerciseTable);
    selectExercise(thisExercise);
    notifyListeners();
  }

  Future<void> incrementExerciseCount(Exercise e, int bump) async {
    if (e.id != selectedExercise!.id) return;
    int i = selectedExercise!.totalCount! + bump;
    Exercise thisExercise = e.copyWith(totalCount: i);
    await _dbHelper.update(thisExercise.toMap(), exerciseTable);
    selectExercise(thisExercise);
    notifyListeners();
  }

  Future<void> updateGeneral(Exercise e) async {
    await _dbHelper.update(e.toMap(), exerciseTable);
    selectExercise(e);
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
      eHelper.eAspectForView(
        aspect: input ?? 'none',
      );

  /// Wrapper for providing data we can actually store
  String eAspectToStringBuilder(Map<String, bool> aspectFromUser) =>
      eHelper.eAspectToString(aspectFromUser);

  /// Access a list of strings for common use
  final List<String> syleKeys = ExerciseKeys.ekeys.style;
  final List<String> targetKeys = ExerciseKeys.ekeys.targets;
  final List<String> equipKeys = ExerciseKeys.ekeys.equip;
}
