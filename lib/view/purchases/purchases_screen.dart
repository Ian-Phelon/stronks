import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronks/controller/controller.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Align(
              alignment: Alignment.center,
              child: Consumer<UserOptions>(
                builder: (_, repo, __) {
                  return Visibility(
                    visible: !repo.getOptionValue(userOptionsIndex: 2),
                    replacement: const SizedBox.shrink(),
                    child: TextButton(
                        onPressed: () {
                          repo.toggleUserRemovedAds();
                        },
                        child: Text(
                          'ok',
                          style: Theme.of(context).textTheme.headline1,
                        )),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
