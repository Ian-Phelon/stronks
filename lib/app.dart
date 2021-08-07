import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/controller.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserOptions>(builder: (context, repo, __) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: repo.getCurrentTheme(),
        color: Theme.of(context).primaryColor,
        title: 'Stronks Fitness',
        routerDelegate: StronksRouterDelegate(),
        routeInformationParser: StronksRouteInformationParser(),
      );
    });
  }
}
