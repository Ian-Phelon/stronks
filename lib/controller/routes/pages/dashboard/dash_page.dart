import 'package:flutter/material.dart';

import '../../../../view/view.dart' show DashboardScreen;

class DashPage extends Page<DashPage> {
  const DashPage()
      : super(
          key: const ValueKey('DashboardPage'),
        );

  @override
  Route<DashPage> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => const DashboardScreen(),
    );
  }
}
