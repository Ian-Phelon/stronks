import 'package:flutter/material.dart';
import '../../../model/model.dart' show Performance;
import '../widgets/widgets.dart';
import './stats_extensions.dart';

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
  // late final DateTime lastPerformedDt;
  late final List<Map<int, int>> everyWeek;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    if (widget.performances.isNotEmpty) {
      everyWeek = getSpan(
        context,
        'week',
        widget.performances,
      );
    } else {
      everyWeek = [];
    }

    super.initState();
  }

  Text weekForView(Iterable<int> exerciseIds, Iterable<int> counts) {
    final StringBuffer namesAndCounts = StringBuffer();

    for (var i = 0; i < counts.length; i++) {
      namesAndCounts.write(
          exerciseIds.elementAt(i).toString().exerciseIdToName(context) +
              ': ' +
              counts.elementAt(i).toString());
      if (i < counts.length - 1) namesAndCounts.write('\n');
    }
    return new Text(
      '$namesAndCounts',
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (widget.performances.isEmpty) {
          return Center(
              child: Text(
                  'You haven\'t done any exercise in a day, much less 7 days ago.'));
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
        return DateSeparator(
          date: spanMarker[index],
          separator: 'week',
        );
      },
      itemCount: everyWeek.length + 1,
    );
  }
}
