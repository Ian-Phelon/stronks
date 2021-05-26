import 'package:flutter/material.dart';
import '../../../../view/view.dart' show EditExerciseScreen;

class EditExercisePage extends Page<EditExercisePage> {
  // const EditExercisePage({Key key, @required this.exercise})
  //     : super(
  //         key: const ValueKey('EditExercisePage'),
  //       );
  // final Exercise exercise;

  @override
  Route<EditExercisePage> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => EditExerciseScreen(
          // exercise: exercise,
          ),
    );
  }
}
