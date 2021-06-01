import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' show MobileAds;
import 'package:provider/provider.dart';

import 'app.dart';
import 'controller/controller.dart';
// import 'model/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  DataHelper(); //.initDB();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DataHelper>(
          create: (_) => DataHelper(),
        ),
        ChangeNotifierProvider<ExerciseRepository>(
          create: (_) => ExerciseRepository(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => RoutePageManager(),
        // )
        // ChangeNotifierProvider(create: (_) => DataHelper.dbAccess),
        // ChangeNotifierProxyProvider<DataHelper, ExerciseRepository>(
        //   create: (_) => ExerciseRepository(),
        //   update: (_, db, previous) => ExerciseRepository(
        //     list: previous!.exerciseList,
        //     dataHelper: DataHelper.dbAccess,
        //   ),
        // ),
      ],
      child: const App(),
    ),
  );
}
