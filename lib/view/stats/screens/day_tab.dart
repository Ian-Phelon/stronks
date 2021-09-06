import 'package:flutter/material.dart';
import '../../../model/model.dart' show Performance;
import './extensions.dart';

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
          var lastDatePerformed =
              performances[index].datePerformed!.parsePerformanceDate();
          return Text('${lastDatePerformed.monthAndDay(context)}',
              style: Theme.of(context).textTheme.headline6);
        }
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            trailing: Text(performance.updatedCount!.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontStyle: FontStyle.italic)),
            tileColor: Theme.of(context).colorScheme.surface,
            title: Text(
                performance.exerciseId!.toString().exerciseIdToName(context),
                style: Theme.of(context).textTheme.headline5),
          ),
        );
      },
      separatorBuilder: (context, index) {
        var thisDt = performances[index].datePerformed!.parsePerformanceDate();
        var lastDt = performances[index.offsetOneBack()]
            .datePerformed!
            .parsePerformanceDate();
        if (thisDt.day != lastDt.day) {
          return Text(
            '${thisDt.monthAndDay(context)}',
            style: Theme.of(context).textTheme.headline6,
          );
        }

        /// default
        return const SizedBox.shrink();
      },
      itemCount: performances.length + 1,
    );
  }
}
