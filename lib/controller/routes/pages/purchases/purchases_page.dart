import 'package:flutter/material.dart';
import '../../../../view/view.dart' show PurchasesScreen;

class PurchasesPage extends Page<PurchasesPage> {
  const PurchasesPage()
      : super(
          key: const ValueKey('PurchasesPage'),
        );
  @override
  Route<PurchasesPage> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => const PurchasesScreen(),
    );
  }
}
