import 'dart:async';

import 'package:flutter/material.dart';
import 'package:score_system/vocabulary/constant.dart';

class IntroPage extends StatelessWidget {

  final BuildContext _ctx;

  IntroPage(this._ctx);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroPageState(_ctx),
    );
  }
}

class IntroPageState extends StatefulWidget {

  final BuildContext _ctx;

  IntroPageState(this._ctx);

  @override
  _IntroPageState createState() => _IntroPageState(_ctx);

}

class _IntroPageState extends State<IntroPageState> {

  final BuildContext _ctx;

  final String title1 = "Детский трекер";
  final String title2 = "отличных привычек";
  final String allImgName = "introAll.png";

  static const timeout = Duration(seconds: 5);
  static const ms = Duration(milliseconds: 1);

  _IntroPageState(this._ctx);

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  Timer startTimeout([int? milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return Timer(duration, handleTimeout);
  }

  void handleTimeout() {  // callback function
    Navigator.pushNamed(this._ctx, '/choose_user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child:
        // Expanded(
          child:
          Column(
            children: [
              Expanded(
                  child:
                  Container(
                    // alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 2 / 3 ,
                          child:
                          Text(
                            title1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FONT_FAMILY_SECOND,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 64,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          child:
                          Text(
                            title2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  )
              ),
              Expanded(
                  child:
                  Container(
                    alignment: Alignment.bottomCenter,
                    child:
                    Padding(
                      // padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 20),
                      padding: EdgeInsets.only(left: 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 8 / 9,
                        height: MediaQuery.of(context).size.height / 2,

                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(IMG_PATH + allImgName),
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                  )
              )
            ],
          )
        // ),
      ),
    );
  }

}