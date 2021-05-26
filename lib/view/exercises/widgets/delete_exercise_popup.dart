import 'package:flutter/material.dart';

class DeleteExercisePopup extends AlertDialog {
  const DeleteExercisePopup({this.deleteExerciseAndTile});

  final VoidCallback? deleteExerciseAndTile;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: TextStyle(fontSize: 45),
      backgroundColor: Colors.deepPurpleAccent,
      title: Text('Delete Exercise?'),
      content: Icon(Icons.outdoor_grill),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('back'),
        ),
        TextButton(
          onPressed: deleteExerciseAndTile,
          child: Text('delete'),
        ),
      ],
      // height: 80.0,
      // width: 60.0,
      // color: Colors.deepPurpleAccent,
    );
  }
}
