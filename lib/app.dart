import 'package:flutter/material.dart';

import 'controller/routes/page_navigation.dart';

import 'model/model.dart' show StronksTheme;

List<ThemeData> ok = [
  StronksTheme.lightMode,
];

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: StronksTheme.lightMode,
      color: Theme.of(context).primaryColor,
      title: 'Stronks Fitness',
      routerDelegate: StronksRouterDelegate(),
      routeInformationParser: StronksRouteInformationParser(),
    );
  }
}
