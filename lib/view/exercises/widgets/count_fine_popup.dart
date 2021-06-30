import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void CounterCallback(int value);

class CountFinePopup extends AlertDialog {
  const CountFinePopup({
    this.editNumberFine,
    required this.onCounterChanged,
  });

  final CounterCallback onCounterChanged;

  final VoidCallback? editNumberFine;

  @override
  Widget build(BuildContext context) {
    // int? changedCount;
    TextEditingController txt = TextEditingController();

    return AlertDialog(
      titleTextStyle: TextStyle(fontSize: 45),
      backgroundColor: Colors.deepPurpleAccent,
      title: Text('Edit Count'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            textAlign: TextAlign.justify,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            // controller: txt,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            autofocus: true,
            keyboardType: TextInputType.number,
            onChanged: (v) => txt.text = v,
            onSubmitted: (v) => txt.text = v,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('back'),
        ),
        TextButton(
          onPressed: () {
            num n = num.tryParse(txt.text == '' ? '0' : txt.text)!;
            onCounterChanged(n.toInt());
            print(n);
            Navigator.of(context).pop();
          },
          child: Text('Update Count'),
        ),
      ],
      // height: 80.0,
      // width: 60.0,
      // color: Colors.deepPurpleAccent,
    );
  }
}
