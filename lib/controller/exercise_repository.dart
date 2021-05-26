import 'package:flutter/material.dart';

import '../model/model.dart' show Exercise;

class ExerciseRepository extends ChangeNotifier {
  int? _unnamedExerciseIndex;

  ///
  Exercise? selectedExercise;
  //Exercise get selectedExercise => _selectedExercise;
  // set selectedExercise(Exercise value) {
  //   _selectedExercise = value;
  //   notifyListeners();
  // }

  void saveExercise(Exercise e) {
    /// handles an empty name. _unnamedExerciseIndex is 0 if this is called for the first time
    // if (e.name == '') e.name = _userSkippedName(_unnamedExerciseIndex ?? 0);
    if (e.name == '')
      e.copyWith(
        name: _userSkippedName(_unnamedExerciseIndex ?? 0),
      );

    /// always starts at 0
    //  e.count = 0;
    e.copyWith(count: 0);

    ///TODO: ACTUALLY SAVE AN EXERCISE
  }

  void selectExercise(Exercise e) {
    selectedExercise = e;
    notifyListeners();
  }

  void updateSelectedExerciseName(String e) {
    if (e == selectedExercise?.name || e == '') return;

    selectedExercise?.copyWith(name: e);
    selectExercise(selectedExercise!);
    // exercisesBox.putAt(selectedExercise.index, selectedExercise);
    notifyListeners();
  }

  void removeExerciseUpdateView(Exercise e) {
    //  exercisesBox.deleteAt(e.index);
    notifyListeners();
  }

  String _userSkippedName(int identity) {
    /// identity WILL BE 0 when `_userSkippedName()` is called for the first time.
    // if (exercisesBox.isEmpty || identity <= 0) {
    //   _unnamedExerciseIndex = 1;
    // }
    // if (exercisesBox.isNotEmpty && _unnamedExerciseIndex >= 1) {
    //   _unnamedExerciseIndex++;
    // }

    return 'Unnamed Exercise #$_unnamedExerciseIndex';
  }

  void incrementExerciseCount(Exercise exercise) {
    int i = exercise.count!;
    exercise.copyWith(
      count: i += 1,
    ); //count++;
    notifyListeners();
  }

  void deleteExerciseList() {
    _unnamedExerciseIndex = null;
    // exercisesBox.clear();
    notifyListeners();
  }
}
