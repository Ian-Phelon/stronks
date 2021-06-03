import 'package:flutter/material.dart';
import './buttons.dart' show RoundIconButton;

class CounterRow extends StatelessWidget {
  final VoidCallback? countOne;
  final VoidCallback? countFive;
  final VoidCallback? countTen;

  const CounterRow(
      {Key? key,
      @required this.countOne,
      @required this.countFive,
      @required this.countTen})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        plusOne(context, countOne!),
        plusFive(context, countFive!),
        plusTen(context, countTen!)
      ],
    );
  }
}

Widget plusOne(BuildContext context, VoidCallback count) {
  return RoundIconButton.asCounter(
      onPressed: count, size: 12.0, elevation: 4.0, countAmount: 1);
}

Widget plusFive(BuildContext context, VoidCallback count) {
  return RoundIconButton.asCounter(
      onPressed: count, size: 12.0, elevation: 4.0, countAmount: 5);
}

Widget plusTen(BuildContext context, VoidCallback count) {
  return RoundIconButton.asCounter(
      onPressed: count, size: 12.0, elevation: 4.0, countAmount: 10);
}
