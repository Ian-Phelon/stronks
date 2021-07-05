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
        fontFamily: kFontFamily,
        appBarTheme: AppBarTheme(
          color: kcolorPurpleDark,
        ),
        textTheme: TextTheme(
          headline2: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: kFontFamily,
              color: Colors.black),
        ),
      ),
      routerDelegate: StronksRouterDelegate(),
      routeInformationParser: StronksRouteInformationParser(),
    );
  }
}
