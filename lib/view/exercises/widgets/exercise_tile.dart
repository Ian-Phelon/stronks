import 'package:flutter/material.dart';

import '../../../model/exercise.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    Key? key,
    required this.exercise,
    required this.selectAndPush,
    required this.deleteExercise,
    required this.titleSize,
  }) : super(key: key);
  final Exercise exercise;
  final VoidCallback selectAndPush;
  final VoidCallback deleteExercise;
  final Size titleSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: selectAndPush,
        onLongPress: deleteExercise,
        child: Material(
          borderOnForeground: true,
          elevation: 4,
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(
              width: 6.0,
              color: Theme.of(context).colorScheme.primaryVariant,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      exercise.name!,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Shares: ${exercise.totalCount}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
