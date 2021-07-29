import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stronks/view/widgets/main_banner_ad.dart';

import 'app.dart';
import 'controller/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: [AdHelper.bannerAdUnitId]));
  await UserOptions.instance.initialize();
  await ExerciseRepository.instance.initialize();
  await StatsHelper.instance.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DataHelper>(
          create: (_) => DataHelper(),
        ),
        ChangeNotifierProvider<ExerciseRepository>(
          create: (_) => ExerciseRepository(),
        ),
        ChangeNotifierProvider<UserOptions>(
          create: (_) => UserOptions.instance,
        ),
        ChangeNotifierProvider<StatsHelper>(
          create: (_) => StatsHelper(),
        ),

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
