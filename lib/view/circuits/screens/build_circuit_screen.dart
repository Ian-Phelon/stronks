import 'package:flutter/material.dart';

class CircuitsScreen extends StatelessWidget {
  const CircuitsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline4!,
      child: GestureDetector(
        onTap: () {
          ///kinda cool how this still works, but we need to use RoutePageManager
          Navigator.of(context).pop();
        },
        child: Container(
          color: Colors.purpleAccent,
          alignment: Alignment.center,
          child: Text('Build Circuit'),
        ),
      ),
    );
  }
}
