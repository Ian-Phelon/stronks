import 'package:flutter/material.dart';

class DeleteExercisePopup extends AlertDialog {
  const DeleteExercisePopup({this.deleteExerciseAndTile});

  final VoidCallback? deleteExerciseAndTile;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentTextStyle: Theme.of(context).textTheme.headline6,
      titleTextStyle: Theme.of(context).textTheme.headline3,
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text('Delete Exercise?'),
      content: Text(
          'Deleting will remove this exercise from your exercise list forever.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        TextButton(
          onPressed: deleteExerciseAndTile,
          child: Text(
            'Delete',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
      // height: 80.0,
      // width: 60.0,
      // color: Colors.deepPurpleAccent,
    );
  }
}
