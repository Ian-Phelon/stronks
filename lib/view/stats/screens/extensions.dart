import 'package:provider/provider.dart' show Provider;
import '../../../controller/controller.dart' show ExerciseRepository;
import 'package:flutter/material.dart' show BuildContext;

extension StatsDates on DateTime {
  String monthAndDay(bool usesMetric) =>
      usesMetric ? '${this.day}/${this.month}' : '${this.month}/${this.day}';
}

extension StatsInts on int {
  int offsetOneBack() => this - 1 < 0 ? 0 : this - 1;
  int offsetOneForward(int length) =>
      this + 1 >= length - 1 ? length - 1 : this + 1;
  Duration days() => Duration(days: this);
}

extension CalendarPerformances on String {
  DateTime parsePerformanceDate() => DateTime.parse(this);
  String exerciseIdToName(BuildContext context) {
    var exerciseName;

    try {
      exerciseName = Provider.of<ExerciseRepository>(context, listen: false)
          .getExercises()
          .singleWhere((e) => e.id == num.tryParse(this))
          .name;
    } catch (e) {
      return 'Deleted Exercise #${this}';
    }

    return exerciseName ?? 'Deleted Exercise';
  }
}
