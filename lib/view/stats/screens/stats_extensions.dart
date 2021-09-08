import '../../../controller/controller.dart'
    show ExerciseRepository, UserOptions;
import '../../../model/model.dart' show Performance;
import 'package:flutter/material.dart' show BuildContext;

extension StatsDates on DateTime {
  String monthAndDay(BuildContext context) =>
      UserOptions.of(context).getOptionValue(userOptionsIndex: 1)
          ? '${this.day}/${this.month}'
          : '${this.month}/${this.day}';
  String monthAndYear() => '${this.month.asMonth()}/${this.year}';
}

extension StatsInts on int {
  int offsetOneBack() => this - 1 < 0 ? 0 : this - 1;
  int offsetOneForward(int length) =>
      this + 1 >= length - 1 ? length - 1 : this + 1;

  /// return a Duration with this many days
  Duration days() => Duration(days: this);

  /// returns the actual month of a DateTime month
  String asMonth() {
    switch (this) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';

      default:
        return '$this is not in the gregorian calendar';
    }
  }
}

extension CalendarPerformances on String {
  DateTime parsePerformanceDate() => DateTime.parse(this);
  String exerciseIdToName(BuildContext context) {
    var exerciseName;

    try {
      exerciseName = ExerciseRepository.of(context)
          .getExercises()
          .singleWhere((e) => e.id == num.tryParse(this))
          .name;
    } catch (e) {
      return 'Deleted Exercise #${this}';
    }

    return exerciseName ?? 'Deleted Exercise';
  }
}

List<Map<int, int>> spanTotal = [];
List<DateTime> spanMarker = [];
void clearSpan() {
  spanTotal.clear();
  spanMarker.clear();
}

void spanTotalAddEmpty() => spanTotal.add(Map<int, int>());
void updateLastSpan(int key, int count) => spanTotal.last
    .update(key, (value) => value += count, ifAbsent: () => count);

DateTime targetWeek() => spanMarker.last.subtract(8.days());
int targetMonth() =>
    spanMarker.last.month - 1 < 1 ? 12 : spanMarker.last.month - 1;
dynamic getTarget(String timeSpan) {
  switch (timeSpan) {
    case 'week':
      return targetWeek();
    case 'month':
      return targetMonth();
    default:
      return 'Big Oops';
  }
}

///timespan: ['week', 'month']
List<Map<int, int>> getSpan(
  BuildContext context,
  String timeSpan,
  List<Performance> performances,
) {
  clearSpan();
  spanMarker.add(performances.first.datePerformed!.parsePerformanceDate());
  var target = getTarget(timeSpan);

  if (target.runtimeType == DateTime) {
    for (var index = 0; index < performances.length; index++) {
      var target = getTarget(timeSpan);
      final e = performances[index];
      final date = e.datePerformed!.parsePerformanceDate();
      final key = e.exerciseId!;
      final count = e.updatedCount!;
      if (spanTotal.length != spanMarker.length) spanTotalAddEmpty();
      if (date.isAfter(target)) updateLastSpan(key, count);
      if (date.isBefore(target) || date.day == target.day) spanMarker.add(date);
      if (spanTotal.length != spanMarker.length) {
        spanTotalAddEmpty();
        updateLastSpan(key, count);
      }
    }
  }
  if (target.runtimeType == int) {
    for (var index = 0; index < performances.length; index++) {
      var target = getTarget(timeSpan);
      final e = performances[index];
      final date = e.datePerformed!.parsePerformanceDate();
      final key = e.exerciseId!;
      final count = e.updatedCount!;
      final bool newYear = date.month == 1 && target == 12;
      if (spanTotal.length != spanMarker.length) spanTotalAddEmpty();
      if (date.month > target || newYear) updateLastSpan(key, count);
      if (date.month == target) spanMarker.add(date);
      if (spanTotal.length != spanMarker.length) {
        spanTotalAddEmpty();
        updateLastSpan(key, count);
      }
    }
  }
  return spanTotal;
}
