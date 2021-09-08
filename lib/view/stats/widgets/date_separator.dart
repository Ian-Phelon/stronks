import 'package:flutter/material.dart';

import '../screens/stats_extensions.dart';

////dev
import '../../../controller/controller.dart' show StatsHelper;

class DateSeparator extends StatelessWidget {
  const DateSeparator({
    Key? key,
    this.separator,
    required this.date,
  }) : super(key: key);
  final String? separator;
  final DateTime date;

  String getDate(BuildContext context, DateTime date) {
    switch (separator) {
      case 'week':
        return '${date.monthAndDay(context)} - ${date.subtract(7.days()).monthAndDay(context)}';
      case 'month':
        return date.monthAndYear();
      default:
        return date.monthAndDay(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(spanMarker);
        // var ok = [];
        // var duh =
        //     StatsHelper.of(context).getPerformanceList().reversed.toList();

        // for (var d in duh) {
        //   ok.add(d.datePerformed);
        // }
        // print(ok);
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          getDate(context, date),
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
          textAlign: TextAlign.left,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 2.0,
                spreadRadius: -1.0,
                color: Theme.of(context).shadowColor,
              ),
              BoxShadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 5.0,
                spreadRadius: 0.0,
                color: Theme.of(context).shadowColor,
              ),
              BoxShadow(
                offset: Offset(3.0, 3.0),
                blurRadius: 3.0,
                spreadRadius: -1.0, //0.0,
                color: Theme.of(context).shadowColor,
              ),
            ]),
      ),
    );
  }
}
