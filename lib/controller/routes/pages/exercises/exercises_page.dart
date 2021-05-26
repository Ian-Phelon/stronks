import 'package:flutter/material.dart';

import '../../../../view/view.dart' show ExercisesScreen;

class ExercisesPage extends Page<ExercisesPage> {
  const ExercisesPage({this.elist})
      : super(
          key: const ValueKey('ExercisesPage'),
        );
  final List<Widget>? elist;

  @override
  Route<ExercisesPage> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => const ExercisesScreen(),
    );
  }
}
