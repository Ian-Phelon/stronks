import 'package:flutter/material.dart';

import 'constants.dart';
import 'controller/routes/page_navigation.dart';

//import 'view/exercises/execise_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        fontFamily: 'Montserrat',
        appBarTheme: AppBarTheme(
          color: colorPurpleDark,
        ),
      ),
      routerDelegate: StronksRouterDelegate(),
      routeInformationParser: StronksRouteInformationParser(),
    );
  }
}
