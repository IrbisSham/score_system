import 'package:flutter/material.dart';
import 'package:score_system/api/graphics.dart';
import 'package:score_system/current_data.dart';
import 'package:score_system/screen/intro_screen.dart';
import 'package:score_system/screen/participants_screen.dart';
import 'package:score_system/screen/person_ava.dart';

class MainMenuPage extends StatelessWidget {

  final String title;
  final Map<String, String> btnTitleMap;

  const MainMenuPage({
    Key? key,
    required this.title,
    required this.btnTitleMap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            tooltip: "Настройки",
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            tooltip: "Участники",
            icon: Icon(
              Icons.people,
              color: Colors.white,
            ),
            onPressed: () {
              ParticipantsPage();
              // do something
            },
          ),
          IconButton(
            tooltip: "Задачи участника",
            icon: Icon(
              Icons.task_alt_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              ParticipantsPage();
            },
          ),
          IconButton(
            tooltip: "Задачи",
            icon: Icon(
              Icons.table_rows_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO Make Task screen
            },
          ),
        ],
      ),
      body: Center(
        // child:
        // Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
                <Widget>[
                  if (CurrentUser.person != null)
                    PersonAva(),
                  Padding(padding: EdgeInsets.all(10)),
                  ...btnTitleMap.entries.map( (entry) => ButtonGen.btnByListAndTextAndPath(context, btnTitleMap.keys.toList(), entry.key, entry.value)).toList(),
                  Padding(padding: EdgeInsets.all(10)),
                ],
          ),
        // ),
      ),
    );
  }
}