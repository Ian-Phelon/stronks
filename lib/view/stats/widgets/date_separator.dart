import 'package:flutter/material.dart';

import '../stats_extensions.dart';

String _getDate(BuildContext context, DateTime date, String? separator) {
  switch (separator) {
    case 'week':
      return '${date.monthAndDay(context)} - ${date.subtract(7.days()).monthAndDay(context)}';
    case 'month':
      return date.monthAndYear();
    default:
      return date.monthAndDay(context);
  }
}

class DateSeparator extends StatelessWidget {
  const DateSeparator({
    Key? key,
    this.separator,
    required this.date,
  }) : super(key: key);
  final String? separator;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6.0, 0, 6.0),
      child: Material(
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            _getDate(context, date, separator),
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
                  offset: Offset(2.0, 2.0),
                  blurRadius: 2.0,
                  spreadRadius: -1.0,
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
      ),
    );
  }
}
