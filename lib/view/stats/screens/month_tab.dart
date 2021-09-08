import 'package:flutter/material.dart';
import '../../../model/model.dart' show Performance;
import '../widgets/widgets.dart';
import 'stats_extensions.dart';

class CalendarMonth extends StatefulWidget {
  const CalendarMonth({
    Key? key,
    required this.performances,
  }) : super(key: key);
  final List<Performance> performances;

  @override
  _CalendarMonthState createState() => _CalendarMonthState();
}

class _CalendarMonthState extends State<CalendarMonth> {
  late final List<Map<int, int>> monthly;
  late final List<DateTime> duh;

  @override
  void initState() {
    if (widget.performances.isNotEmpty) {
      monthly = getSpan(context, 'month', widget.performances);
    } else {
      monthly = [];
    }
    super.initState();
  }

  Text monthForView(Iterable<int> exerciseIds, Iterable<int> counts) {
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
      style: Theme.of(context).textTheme.headline5!.copyWith(height: 1.6),
      softWrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (widget.performances.isEmpty) {
            return Center(
                child: Text(
                    'You really should get some exercise instead of always scrolling.'));
          }
          if (index == 0) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: monthForView(monthly[index.offsetOneBack()].keys,
                  monthly[index.offsetOneBack()].values),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return DateSeparator(
            date: spanMarker[index],
            separator: 'month',
          );
        },
        itemCount: monthly.length + 1);
  }
}
