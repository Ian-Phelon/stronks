import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' show MobileAds;
import 'package:provider/provider.dart';

import 'app.dart';
import 'controller/controller.dart';
import 'model/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ExerciseRepository(),
        ),
      ],
      child: const App(),
    ),
  );
}
