import 'package:flutter/material.dart';
import '../../../model/model.dart' show Performance;
import '../stats_extensions.dart';
import '../widgets/widgets.dart';

class CalendarDay extends StatelessWidget {
  const CalendarDay({
    Key? key,
    required this.performances,
  }) : super(key: key);
  final List<Performance> performances;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (performances.isEmpty) {
          return Center(child: Text('You should do some exercise.'));
        }
        var performance = performances[index.offsetOneBack()];
        if (index == 0) {
          return DateSeparator(
            date: performances[index].datePerformed!.parsePerformanceDate(),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Material(
            elevation: 2.0,
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(
                width: 0.5,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      performance.exerciseId!
                          .toString()
                          .exerciseIdToName(context),
                      style: Theme.of(context).textTheme.headline5),
                  Text(performance.updatedCount!.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        final thisDt =
            performances[index].datePerformed!.parsePerformanceDate();
        final lastDt = performances[index.offsetOneBack()]
            .datePerformed!
            .parsePerformanceDate();
        if (thisDt.day != lastDt.day) {
          return DateSeparator(date: thisDt);
        }

        return const SizedBox.shrink();
      },
      itemCount: performances.length + 1,
    );
  }
}
