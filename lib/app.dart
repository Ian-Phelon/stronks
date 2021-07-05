import 'package:flutter/material.dart';

import 'controller/routes/page_navigation.dart';
import 'constants.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: kFontFamily,
        appBarTheme: const AppBarTheme(
          color: kcolorPurpleDark,
        ),
        textTheme: const TextTheme(
          headline2: const TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: kFontFamily,
            color: Colors.black,
          ),
          headline6: const TextStyle(color: Colors.black),
        ),
      ),
      routerDelegate: StronksRouterDelegate(),
      routeInformationParser: StronksRouteInformationParser(),
    );
  }
}
