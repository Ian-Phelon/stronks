import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void CounterCallback(int value);

class CountFinePopup extends AlertDialog {
  const CountFinePopup({
    required this.onCounterChanged,
    required this.whichCount,
  });

  final CounterCallback onCounterChanged;
  final int whichCount;

  @override
  Widget build(BuildContext context) {
    // int? changedCount;

    TextEditingController txt = TextEditingController();
    return AlertDialog(
      contentTextStyle: Theme.of(context).textTheme.headline4,
      titleTextStyle: Theme.of(context).textTheme.headline4,
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text('Add To $whichCount'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 29,
              ),
              Container(
                width: 69,
                child: TextField(
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.ltr,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    txt.text = v;
                    // n = num.tryParse(txt.text == '' ? '0' : txt.text)!;
                  },
                  onSubmitted: (v) => txt.text = v,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            txt.dispose();
            Navigator.pop(context);
          },
          child: Text('Back'),
        ),
        TextButton(
          onPressed: () {
            num n = num.tryParse(txt.text == '' ? '0' : txt.text)!;
            onCounterChanged(n.toInt());
            txt.dispose();
            Navigator.of(context).pop();
          },
          child: Text('Update Count'),
        ),
      ],
    );
  }
}
