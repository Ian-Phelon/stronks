import 'package:flutter/material.dart';

class TradingPlatformScreen extends StatelessWidget {
  const TradingPlatformScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline4!,
      child: GestureDetector(
        onTap: () {
          // This moves from the Build Exercise page to the credentials page,
          // replacing this page with that one.
          Navigator.of(context).pop();
        },
        child: Container(
          color: Colors.pink,
          alignment: Alignment.center,
          child: Text('Trading Platform'),
        ),
      ),
    );
  }
}
