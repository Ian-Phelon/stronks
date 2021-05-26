import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MainPage(),
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color go = Colors.green;
  Color stop = Colors.red;

// the variable we are tracking the state of
  late bool stackIsGo;

// custom widget that takes a bool as input
  Widget _moreWidgets(bool changeColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: changeColor ? Colors.greenAccent : Colors.deepPurple,
          height: 44,
          width: 44,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // the variable the build context is going to build with.
    // since stackIsGo hasn't been given a value yet, and we can't // initialize a null value, if stackIsGo is null we assign
    // true to changeVisibility.
    bool changeVisibility = stackIsGo ?? true;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  color: changeVisibility ? go : stop,
                ),
                Positioned.fill(
                  child: Visibility(
                    visible: !changeVisibility,
                    replacement: SizedBox.shrink(),
                    child: Icon(Icons.warning_rounded),
                  ),
                ),
              ],
            ),
          ),
          FloatingActionButton(
            child: Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                // by using setState inside of the build method,
                // we trigger a widget rebuild with the new value.
                if (stackIsGo == null) stackIsGo = true;
                stackIsGo = !stackIsGo;
              });
            },
          ),
          _moreWidgets(changeVisibility),
        ],
      ),
    );
  }
}
