import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../model/exercise.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    Key? key,
    required this.exercise,
    required this.selectAndPush,
    required this.deleteExercise,
  }) : super(key: key);
  final Exercise exercise;
  final VoidCallback selectAndPush;
  final VoidCallback deleteExercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: selectAndPush,
        onLongPress: deleteExercise,
        child: Material(
          shadowColor: colorPurpleDark,
          borderOnForeground: true,
          elevation: 4,
          color: colorPurpleLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(
              width: 6.0,
              color: colorPurpleDark,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  exercise.name!,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Shares: ${exercise.totalCount}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
