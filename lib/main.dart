import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stronks/view/widgets/main_banner_ad.dart';

import 'app.dart';
import 'controller/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: [AdHelper.bannerAdUnitId]));
  var db = DataHelper(); //.initDB();
  ExerciseRepository();
  await UserOptions.instance.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DataHelper>(
          create: (_) => db,
        ),
        ChangeNotifierProvider<ExerciseRepository>(
          create: (_) => ExerciseRepository(),
        ),
        ChangeNotifierProvider<UserOptions>(
          create: (_) => UserOptions.instance,
        )

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
