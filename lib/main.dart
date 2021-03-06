import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './app.dart';
import './controller/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await UserOptions.instance.initialize();
  await ExerciseRepository.instance.initialize();
  await StatsHelper.instance.initialize();
  await Firebase.initializeApp();

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
          create: (_) => StatsHelper.instance,
        ),
        ChangeNotifierProvider<StronksAuth>(
          create: (_) => StronksAuth.instance,
        )
      ],
      child: const App(),
    ),
  );
}
