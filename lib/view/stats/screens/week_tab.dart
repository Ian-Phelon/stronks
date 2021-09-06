import 'package:flutter/material.dart';
import '../../../controller/controller.dart' show UserOptions;
import '../../../model/model.dart' show Performance;
import './extensions.dart';

List<Map<int, int>> weekList = [];
List<DateTime> weekMarker = [];
void clearWeeks() {
  weekList.clear();
  weekMarker.clear();
}

void addAWeek() => weekList.add(Map<int, int>());
void updateWeek(int key, int count) =>
    weekList.last.update(key, (value) => value += count, ifAbsent: () => count);
DateTime targetDate() => weekMarker.last.subtract(8.days());

List<Map<int, int>> weeks(
    BuildContext context, List<Performance> performances) {
  clearWeeks();
  weekMarker.add(performances.first.datePerformed!.parsePerformanceDate());
  for (var index = 0; index < performances.length; index++) {
    var target = targetDate();
    var e = performances[index];
    var date = e.datePerformed!.parsePerformanceDate();
    var key = e.exerciseId!;
    var count = e.updatedCount!;

    if (weekList.length != weekMarker.length) addAWeek();
    if (date.isAfter(target)) updateWeek(key, count);
    if (date.isBefore(target)) weekMarker.add(date);
    if (weekList.length != weekMarker.length) {
      addAWeek();
      updateWeek(key, count);
    }
  }

  return weekList;
}

class CalendarWeek extends StatefulWidget {
  const CalendarWeek({
    Key? key,
    required this.performances,
  }) : super(key: key);
  final List<Performance> performances;

  @override
  _CalendarWeekState createState() => _CalendarWeekState();
}

class _CalendarWeekState extends State<CalendarWeek> {
  late DateTime lastPerformedDt;
  // late List<Map<int, int>> nameAndTotalByWeek;
  late final List<Map<int, int>> everyWeek;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    if (widget.performances.isEmpty) {
      lastPerformedDt = DateTime.now();
    } else {
      lastPerformedDt =
          widget.performances.first.datePerformed!.parsePerformanceDate();
      everyWeek = weeks(context, widget.performances);
    }
    super.initState();
  }

  Text weekForView(Iterable<int> exerciseIds, Iterable<int> counts) {
    StringBuffer namesAndCounts = StringBuffer();

    for (var i = 0; i < counts.length; i++) {
      namesAndCounts.write(
          exerciseIds.elementAt(i).toString().exerciseIdToName(context) +
              ': ' +
              counts.elementAt(i).toString());
      if (i < counts.length - 1) namesAndCounts.write('\n');
    }
    return Text(
      '$namesAndCounts',
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (widget.performances.isEmpty) {
          return Center(child: Text('You should do some exercise.'));
        }
        if (index == 0) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            title: weekForView(everyWeek[index.offsetOneBack()].keys,
                everyWeek[index.offsetOneBack()].values),
            tileColor: Theme.of(context).colorScheme.surface,
          ),
        );
      },
      separatorBuilder: (context, index) {
        var weekStart = weekMarker[index];
        //.month.toString() +
        //     '/' +
        //     weekMarker[index].day.toString();

        var weekEnd = weekMarker[index].subtract(7.days());
        // var weekEnds = weekEnd.month.toString() + '/' + weekEnd.day.toString();

        return Text(
          '${weekStart.monthAndDay(UserOptions.of(context).getOptionValue(userOptionsIndex: 1))} - ${weekEnd.monthAndDay(UserOptions.of(context).getOptionValue(userOptionsIndex: 1))}',
          style: Theme.of(context).textTheme.headline6,
        );
      },
      itemCount: everyWeek.length + 1, //widget.performances.length + 1,
    );
  }
}
