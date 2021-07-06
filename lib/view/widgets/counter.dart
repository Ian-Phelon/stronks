import 'package:flutter/material.dart';
import './buttons.dart' show RoundIconButton;

class CounterRow extends StatelessWidget {
  final VoidCallback countOne;
  final VoidCallback countFive;
  final VoidCallback countTen;

  const CounterRow(
      {Key? key,
      required this.countOne,
      required this.countFive,
      required this.countTen})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [plusOne(countOne), plusFive(countFive), plusTen(countTen)],
    );
  }
}

Widget plusOne(VoidCallback count) {
  return RoundIconButton(onTap: count, countAmount: 1);
}

Widget plusFive(VoidCallback count) {
  return RoundIconButton(onTap: count, countAmount: 5);
}

Widget plusTen(VoidCallback count) {
  return RoundIconButton(onTap: count, countAmount: 10);
}
