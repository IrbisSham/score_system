import 'package:flutter/material.dart';
import 'package:score_system/vocabulary/constant.dart';

class MainMasterPage extends StatelessWidget {

  final String title1 = "Детский трекер";
  final String title2 = "отличных привычек";
  final String allImgName = "introAll.png";

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