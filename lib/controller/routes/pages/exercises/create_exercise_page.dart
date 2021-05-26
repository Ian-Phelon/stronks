import 'package:flutter/material.dart';
import '../../../../view/view.dart' show CreateExerciseScreen;

class CreateExercisePage extends Page<CreateExercisePage> {
  const CreateExercisePage()
      : super(
          key: const ValueKey('CreateExercisePage'),
        );
  @override
  Route<CreateExercisePage> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => const CreateExerciseScreen(),
    );
  }
}
