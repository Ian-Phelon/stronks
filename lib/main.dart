import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' show MobileAds;
import 'package:provider/provider.dart';

import 'app.dart';
import 'controller/controller.dart';
// import 'model/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  DataHelper.dbAccess.initDB();
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (_) => ExerciseRepository(),
        // ),
        ChangeNotifierProvider(create: (_) => DataHelper.dbAccess),
        ChangeNotifierProxyProvider<DataHelper, ExerciseRepository>(
          create: (_) => ExerciseRepository.withDB([], null),
          update: (_, db, previous) => ExerciseRepository.withDB(
              previous!.exerciseList, DataHelper.dbAccess),
        ),
      ],
      child: const App(),
    ),
  );
}
