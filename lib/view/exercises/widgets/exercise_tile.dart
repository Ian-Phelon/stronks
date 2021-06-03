import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controller/controller.dart';
import '../../../model/exercise.dart';
import 'widgets.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    Key? key,
    @required this.exercise,
  }) : super(key: key);
  final Exercise? exercise;
  @override
  Widget build(BuildContext context) {
    final repoWatch = context.watch<ExerciseRepository>();
    final repoRead = context.read<ExerciseRepository>();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          repoRead.selectExercise(this.exercise!);
          RoutePageManager.of(context).toEditExerciseScreen(this.exercise!);
        },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                DeleteExercisePopup(deleteExerciseAndTile: () {
              Navigator.pop(context);
              repoWatch.removeExerciseUpdateView(this.exercise!);
            }),
          );
        },
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
                  exercise!.name!,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Shares: ${exercise!.totalCount.toString()}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
