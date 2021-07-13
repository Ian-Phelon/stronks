import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

// import '../constants.dart';
import '../constants.dart';
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

  late Exercise? selectedExercise;

  List<Exercise> getExercises() {
    fetchAndSetData();
    return exerciseList;
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

  Future<void> removeExerciseFromDB(Exercise e) async {
    await _dbHelper.delete(e.id!, table);
    notifyListeners();
  }

  Future<void> updateSelectedExerciseName(String e) async {
    if (e == selectedExercise?.name || e == '') return;
    Exercise thisExercise = selectedExercise!.copyWith(name: e);
    await _dbHelper.update(thisExercise.toMap(), table);
    selectExercise(thisExercise);
    notifyListeners();
  }

  Future<void> incrementExerciseCount(Exercise e, int bump) async {
    if (e.id != selectedExercise!.id) return;
    int i = selectedExercise!.totalCount! + bump;
    Exercise thisExercise = e.copyWith(totalCount: i);
    await _dbHelper.update(thisExercise.toMap(), table);
    selectExercise(thisExercise);
    notifyListeners();
  }

  Future<void> updateGeneral(Exercise e) async {
    await _dbHelper.update(e.toMap(), table);
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
