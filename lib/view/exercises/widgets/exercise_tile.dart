import 'package:flutter/material.dart';

import '../../../constants.dart';
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
          shadowColor: kcolorPurpleDark,
          borderOnForeground: true,
          elevation: 4,
          color: kcolorPurpleLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: BorderSide(
              width: 6.0,
              color: kcolorPurpleDark,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: titleSize.height,
                  width:
                      titleSize.width >= MediaQuery.of(context).size.width * 0.8
                          ? MediaQuery.of(context).size.width * 0.3
                          : titleSize.width,
                  child: Text(
                    exercise.name!,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                  ),
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
