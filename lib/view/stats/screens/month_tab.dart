import 'package:flutter/material.dart';
import '../../../model/model.dart' show Performance;
import './extensions.dart';

class CalendarMonth extends StatelessWidget {
  const CalendarMonth({
    Key? key,
    required this.performances,
  }) : super(key: key);
  final List<Performance> performances;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
