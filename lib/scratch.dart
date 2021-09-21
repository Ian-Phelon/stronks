import 'package:flutter/material.dart';

void main() {
  runApp(ScratchApp());
}

class ScratchApp extends StatelessWidget {
  const ScratchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScratchAppHome(),
      initialRoute: '/scratch',
      routes: {
        '/scratch': (BuildContext context) => ScratchAppHome(),
      },
    );
  }
}

class ScratchAppHome extends StatelessWidget {
  const ScratchAppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Ok(),
      ),
    );
    //  Scaffold(
    //   appBar: AppBar(
    //     title: Text('Scrath'),
    //   ),
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text(
    //         'Hi',
    //         style: TextStyle(fontSize: 66, color: Colors.black),
    //       )
    //     ],
    //   ),
    // );
  }
}

class Ok extends StatelessWidget {
  const Ok({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // Figma Flutter Generator DashscreenWidget - FRAME
        Container(
      width: 411,
      height: 823,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 224, 251, 1),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 525,
            left: 29,
            child: Container(
              width: 350,
              height: 50,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(196, 196, 196, 1),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 91,
                    child: Text(
                      'this is adspace',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 427,
            left: 26,
            child: Container(
              width: 355,
              height: 68,
              child: Stack(children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 355,
                      height: 68,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(3, 3),
                              blurRadius: 2)
                        ],
                        color: Color.fromRGBO(255, 241, 253, 1),
                        border: Border.all(
                          color: Color.fromRGBO(152, 126, 178, 1),
                          width: 6,
                        ),
                      ),
                    )),
                Positioned(
                    top: 2,
                    left: 2,
                    child: Text(
                      'STATS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(86, 3, 170, 1),
                          fontFamily: 'Montserrat',
                          fontSize: 48,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    )),
              ]),
            ),
          ),
          Positioned(
            top: 329,
            left: 26,
            child: Container(
              width: 355,
              height: 68,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 355,
                      height: 68,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(3, 3),
                              blurRadius: 2),
                        ],
                        color: Color.fromRGBO(255, 241, 253, 1),
                        border: Border.all(
                          color: Color.fromRGBO(152, 126, 178, 1),
                          width: 6,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    left: 2,
                    child: Text(
                      'EXERCISES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(86, 3, 170, 1),
                          fontFamily: 'Montserrat',
                          fontSize: 48,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 411,
              height: 56,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 411,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(159, 63, 255, 1),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Text(
                      'Encouragement',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Icon(Icons.menu),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
