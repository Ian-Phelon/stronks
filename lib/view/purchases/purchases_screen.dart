import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/controller.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = StronksAuth.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Purchases'),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            // child:
            auth.appleButton(),
            // ),
            // Container(
            // child:
            auth.googleButton(),
            // )
          ],
        ),
      ),
    );
  }
}
